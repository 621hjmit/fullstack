let currentPage = 1;
let itemsPerPage = 10;
let totalItems;
let filters = {}; // 전역 변수로 filters 선언

// 페이지 로드 시 제품 목록 로드 및 항목 수 변경 이벤트 설정
document.addEventListener("DOMContentLoaded", async function() {
	await loadProductList(currentPage, itemsPerPage, filters);
	loadMainCategories();

	// 항목 수 변경 이벤트 리스너
	const itemsPerPageSelect = document.querySelector("#itemsPerPageSelect");
	if (itemsPerPageSelect) { // 요소가 있는지 확인
		itemsPerPageSelect.addEventListener("change", (event) => {
			itemsPerPage = parseInt(event.target.value, 10);
			currentPage = 1; // 항목 수 변경 시 첫 페이지로 이동
			loadProductList(currentPage, itemsPerPage, filters); // 필터 유지
		});
	} else {
		console.error("itemsPerPageSelect 요소를 찾을 수 없습니다.");
	}

	// 검색 버튼 클릭 이벤트 리스너 추가
	const searchButton = document.querySelector(".btn-primary.search-button"); // 특정 클래스나 ID로 검색 버튼을 찾음
	if (searchButton) {
		searchButton.addEventListener("click", function(event) {
			event.preventDefault(); // 기본 폼 제출 동작 방지
			search(); // 검색 함수 호출
		});
	} else {
		console.error("검색 버튼을 찾을 수 없습니다.");
	}

	// 초기화 버튼 클릭 이벤트 리스너 추가
	const resetButton = document.querySelector(".btn-secondary");
	if (resetButton) {
		resetButton.addEventListener("click", function(event) {
			event.preventDefault();
			resetFilters();
		});
	} else {
		console.error("초기화 버튼을 찾을 수 없습니다.");
	}
});

// 검색 함수 추가
function search(event) {
	if (event) {
		event.preventDefault(); // 기본 폼 제출 동작 방지
	}

	const condition = document.getElementById("selectCondition").value;
	const keyword = document.getElementById("keyword").value.trim();
	const mainCategoryId = document.getElementById("mainCategorySelect").value;
	const subCategoryId = document.getElementById("subCategorySelect").value;
	const detailCategoryId = document.getElementById("detailCategorySelect").value;

	filters = {};

	// 검색 조건에 따른 키워드 필터 적용
	if (condition === "1" && keyword) {
		filters.piName = keyword;  // 제품명으로 검색
	} else if (condition === "2" && keyword) {
		filters.piCode = keyword;  // 제품번호로 검색
	}

	// 카테고리 필터 적용
	if (mainCategoryId) {
		filters.piMainCategoryId = parseInt(mainCategoryId, 10);
	}
	if (subCategoryId) {
		filters.piSubCategoryId = parseInt(subCategoryId, 10);
	}
	if (detailCategoryId) {
		filters.piDetailCategoryId = parseInt(detailCategoryId, 10);
	}

	// 검색어와 카테고리 둘 다 비어있다면 경고 메시지
	if (!keyword && !mainCategoryId && !subCategoryId && !detailCategoryId) {
		alert("검색어 또는 카테고리를 선택하세요.");
		return;
	}

	console.log("필터:", filters);

	// 이후 검색 API 호출
	loadProductList(currentPage, itemsPerPage, filters);
}

// 초기화 함수: 모든 필터와 입력 필드를 기본 상태로 초기화
function resetFilters() {
	// 검색 조건 초기화
	document.getElementById("selectCondition").value = "1";

	// 검색어 입력 필드 초기화
	document.getElementById("keyword").value = "";

	// 카테고리 선택 초기화
	document.getElementById("mainCategorySelect").value = "";
	document.getElementById("subCategorySelect").value = "";
	document.getElementById("detailCategorySelect").value = "";

	// filters 객체 초기화
	filters = {};

	// 필요한 경우 필터에 맞춰 제품 목록 다시 로드 (예: 전체 목록)
	loadProductList(1, itemsPerPage, filters); // 페이지와 항목 수를 초기값으로 설정해서 호출
}

// 제품 목록 로드 함수
async function loadProductList(page, itemsPerPage, filters = {}) {
	currentPage = page;
	try {
		// 제품 목록 불러오기
		const response = await axios.get("/product-pagination", {
			params: {
				page: page,
				itemsPerPage: itemsPerPage,
				...filters
			}
		});
		const { list: products, totalItems: totalItemsCount } = response.data;
		totalItems = totalItemsCount;

		// 총 제품수 업데이트
		document.getElementById("totalItemsText").textContent = `${totalItems}`;

		const tableBody = document.querySelector("#dataTable tbody");
		tableBody.innerHTML = ""; // 기존 테이블 내용을 비웁니다.

		if (!products || products.length === 0) {
			console.log("불러온 제품이 없습니다.");
			return;
		}

		// Document Fragment를 사용하여 테이블 행을 추가
		const fragment = document.createDocumentFragment();

		// 제품 데이터를 반복하면서 테이블에 추가
		for (let product of products) {
			try {
				// 카테고리 정보 및 추가 정보를 비동기 요청으로 불러오기
				const [mainCategoryResponse, subCategoryResponse, detailCategoryResponse, stockResponse, onlineResponse] = await Promise.all([
					axios.get(`/mainCategories/${product.piMainCategoryId}`),
					axios.get(`/subCategories/${product.piSubCategoryId}`),
					axios.get(`/detailCategories/${product.piDetailCategoryId}`),
					axios.get(`/product-stock-info/${product.piId}`),
					axios.get(`/product-online/${product.piId}`)
				]);

				const mainCategoryName = mainCategoryResponse.data.mainCategoryName || "N/A";
				const subCategoryName = subCategoryResponse.data.subCategoryName || "N/A";
				const detailCategoryName = detailCategoryResponse.data.detailCategoryName || "N/A";
				const productQuantity = stockResponse.data.quantity || 0;
				const isOnline = Boolean(onlineResponse.data.online);

				// 온라인 구매 아이콘 클래스 결정
				const onlineIconClass = isOnline
					? 'ph-duotone ph-check-circle text-success f-24'
					: 'ph-duotone ph-x-circle text-danger f-24';

				// 동적으로 테이블의 각 행을 생성
				const tableRow = document.createElement("tr");
				tableRow.innerHTML = `
                    <tr>
                        <td><input type="checkbox" class="check" value="${product.piId}" name="piId"></td>
                        <td>
                            <div class="row">
                                <div class="col-auto pe-0">
                                    <img src="/uploads/${product.pimgUrl}" alt="product-image" class="wid-50 rounded">
                                </div>
                                <div class="col">
                                    <h6 class="mb-1">${product.piName}</h6>
                                    <p class="text-muted f-12 mb-0">${product.piCode}</p>
                                </div>
                            </div>
                        </td>
                        <td>
                            ${mainCategoryName} > ${subCategoryName} > ${detailCategoryName}
                        </td>
                        <td class="text-end">₩ ${Number(product.piPrice).toLocaleString()}</td>
                        <td class="text-end" id="stock-${product.piId}">${productQuantity}개</td>
                        <td class="text-center">
                            <i class="${onlineIconClass}" data-bs-toggle="tooltip" data-bs-title="${isOnline ? '구매 가능' : '구매 불가'}"></i>
                        </td>
                        <td class="text-center" style="padding-right:0px">
                            <ul class="list-inline me-auto mb-0">
                                <li class="list-inline-item align-bottom" data-bs-toggle="tooltip" title="상품 보러가기">
                                    <a href="/views/product/detail?piId=${product.piId}" class="avtar avtar-xs btn-link-secondary btn-pc-default" target="_blank">
                                        <i class="ti ti-eye f-18"></i>
                                    </a>
                                </li>
                                <li class="list-inline-item align-bottom" data-bs-toggle="tooltip" title="수정 및 상세보기">
                                    <a href="/admin/product/product-update?piId=${product.piId}" class="avtar avtar-xs btn-link-success btn-pc-default">
                                        <i class="ti ti-edit-circle f-18"></i>
                                    </a>
                                </li>
                                <li class="list-inline-item align-bottom" data-bs-toggle="tooltip" title="삭제">
                                    <a href="#" class="avtar avtar-xs btn-link-danger btn-pc-default" onclick="deleteProduct(${product.piId})">
                                        <i class="ti ti-trash f-18"></i>
                                    </a>
                                </li>
                            </ul>
                        </td>
                    </tr>
                `;
				fragment.appendChild(tableRow);

			} catch (error) {
				console.error("제품 데이터 처리 중 오류 발생:", error);
			}
		}

		tableBody.appendChild(fragment);

		// 페이지네이션 렌더링
		renderPagination(totalItems, itemsPerPage, page);

		// 체크박스 이벤트 리스너 추가 - 선택 제품 수 업데이트
		document.querySelectorAll('.check').forEach(checkbox => {
			checkbox.addEventListener('click', () => {
				const selectedCount = document.querySelectorAll('.check:checked').length;
				document.getElementById('selectedItemsText').textContent = `${selectedCount}`;
			});
		});

	} catch (error) {
		console.error("제품 목록 불러오기 중 오류 발생:", error);
	}
}


// 페이지네이션 렌더링 함수
function renderPagination(totalItems, itemsPerPage, currentPage) {
	const totalPages = Math.ceil(totalItems / itemsPerPage);
	const paginationContainer = document.querySelector("#pagination");
	paginationContainer.innerHTML = ""; // 기존 버튼을 비웁니다.

	const ul = document.createElement("ul");
	ul.classList.add("pagination", "justify-content-center");

	for (let i = 1; i <= totalPages; i++) {
		const li = document.createElement("li");
		li.className = "page-item";

		const button = document.createElement("button");
		button.className = "page-link";
		button.textContent = i;

		// 현재 페이지 표시
		if (i === currentPage) {
			li.classList.add("active");
		}

		// 페이지 버튼 클릭 이벤트 리스너
		button.addEventListener("click", () => {
			currentPage = i;
			loadProductList(currentPage, itemsPerPage, filters); // 필터를 유지하여 제품 목록 로드
		});

		li.appendChild(button);
		ul.appendChild(li);
	}

	paginationContainer.appendChild(ul);
}

// 온라인 구매 여부 변경 함수
async function toggleOnlinePurchase() {
	const selectedProducts = document.querySelectorAll(".check:checked");
	if (selectedProducts.length === 0) {
		alert("변경할 제품을 선택하세요.");
		return;
	}

	try {
		for (let checkbox of selectedProducts) {
			const piId = checkbox.value;
			const onlineResponse = await axios.get(`/product-online/${piId}`);
			const isOnline = Boolean(onlineResponse.data.online);
			// 온라인 구매 여부를 토글
			await axios.put(`/product-online/${piId}`, { online: !isOnline });
		}
		alert("온라인 구매 여부가 변경되었습니다.");
		await loadProductList(); // 변경 후 제품 목록 갱신
	} catch (error) {
		console.error("온라인 구매 여부 변경 중 오류 발생:", error);
		alert("온라인 구매 여부 변경 중 오류가 발생했습니다.");
	}
}

// 제품 일괄 삭제 함수
async function deleteSelectedProducts() {
    const selectedProducts = document.querySelectorAll(".check:checked");
    if (selectedProducts.length === 0) {
        alert("삭제할 제품을 선택하세요.");
        return;
    }

    if (confirm("선택한 제품을 정말 삭제하시겠습니까?")) {
        try {
            for (let checkbox of selectedProducts) {
                const piId = checkbox.value;
                await axios.delete(`/product/${piId}`);
            }
            alert("선택한 제품이 삭제되었습니다.");

            // 삭제 후 현재 페이지의 제품이 남아있는지 확인
            const response = await axios.get("/product-pagination", {
                params: {
                    page: currentPage,
                    itemsPerPage: itemsPerPage,
                    ...filters
                }
            });

            // 만약 현재 페이지에 남아있는 제품이 없다면 이전 페이지로 이동
            if (response.data.list.length === 0 && currentPage > 1) {
                currentPage -= 1;
            }

            // 삭제 후 현재 페이지의 제품 목록을 다시 로드합니다.
            await loadProductList(currentPage, itemsPerPage, filters);
        } catch (error) {
            console.error("제품 삭제 중 오류 발생:", error);
            alert("제품 삭제 중 오류가 발생했습니다.");
        }
    }
}

// 색상 추가 버튼 클릭 함수
function handleColorAddButtonClick() {
	const checkedProducts = document.querySelectorAll(".check:checked");

	if (checkedProducts.length > 1) {
		alert("한 가지 제품만 선택해 주세요.");
		return;
	} else if (checkedProducts.length === 0) {
		alert("제품을 선택해 주세요.");
		return;
	}

	if (checkedProducts.length === 1) {
		const piId = checkedProducts[0].value;
		window.location.href = `/admin/product/product-update-add-color?piId=` + piId;
	}
}

// 체크박스 모두 선택/해제 함수
function check_all(className, checkbox) {
	const checkboxes = document.querySelectorAll('.' + className);
	checkboxes.forEach(function(checkboxItem) {
		checkboxItem.checked = checkbox.checked;
	});

	// 선택된 제품 수 업데이트
	updateSelectedProductCount();
}

// 선택된 제품 수를 업데이트하는 함수
function updateSelectedProductCount() {
	const selectedCount = document.querySelectorAll('.check:checked').length;
	document.getElementById('selectedItemsText').textContent = `${selectedCount}`;
}

// 체크박스 개별 선택 시 모든 선택 여부 확인 함수
function check(checkbox) {
	var allCheckbox = document.querySelector('.allChk');
	var checkboxes = document.querySelectorAll('.check');
	var allChecked = true;
	checkboxes.forEach(function(checkboxItem) {
		if (!checkboxItem.checked) {
			allChecked = false;
		}
	});
	allCheckbox.checked = allChecked;
}

// 개별 제품 삭제 함수
async function deleteProduct(piId) {
    if (confirm("정말 이 제품을 삭제하시겠습니까?")) {
        try {
            await axios.delete(`/product/${piId}`);
            alert('제품이 삭제되었습니다.');

            // 제품 목록을 다시 로드합니다.
            // 삭제 후 제품이 남아있는지 확인하고, 남아있지 않으면 이전 페이지로 이동
            const response = await axios.get("/product-pagination", {
                params: {
                    page: currentPage,
                    itemsPerPage: itemsPerPage,
                    ...filters
                }
            });

            if (response.data.list.length === 0 && currentPage > 1) {
                currentPage -= 1; // 현재 페이지에 제품이 없으면 이전 페이지로 이동
            }

            // 삭제 후 현재 페이지의 제품 목록을 로드합니다.
            await loadProductList(currentPage, itemsPerPage, filters);
        } catch (error) {
            console.error('제품 삭제 중 오류 발생:', error);
            alert('제품 삭제 중 오류가 발생했습니다.');
        }
    }
}


// 선택된 제품들의 재고를 일괄적으로 수정하는 함수
async function updateSelectedProductStock() {
	// 체크된 체크박스를 모두 선택
	const selectedProducts = document.querySelectorAll(".check:checked");

	if (selectedProducts.length === 0) {
		alert("재고를 수정할 제품을 선택하세요.");
		return;
	}

	// prompt 창을 통해 모든 선택된 제품의 새로운 재고 수량을 입력받음
	const newStock = prompt(`선택된 ${selectedProducts.length}개의 제품에 대한 새로운 재고 수량을 입력하세요:`);
	if (newStock === null) {
		// 사용자가 취소를 누른 경우 아무 작업도 하지 않음
		return;
	}

	const parsedStock = parseInt(newStock);
	if (isNaN(parsedStock) || parsedStock < 0) {
		alert("유효한 숫자를 입력하세요.");
		return;
	}

	// 모든 선택된 제품의 재고를 서버에 업데이트 요청
	try {
		for (let checkbox of selectedProducts) {
			const piId = checkbox.value;

			// 서버에 재고 업데이트 요청
			await axios.put(`/product-stock/${piId}`, {
				quantity: parsedStock
			});

			// 재고 수량이 정상적으로 업데이트된 경우 UI 갱신
			const stockElement = document.querySelector(`#stock-${piId}`);
			if (stockElement) {
				stockElement.innerText = `${parsedStock}개`;
			} else {
				console.warn(`제품 ID ${piId}에 대한 재고 표시 요소를 찾을 수 없습니다.`);
			}
		}

		alert(`선택된 ${selectedProducts.length}개의 제품에 대한 재고 수량이 성공적으로 수정되었습니다.`);
	} catch (error) {
		console.error(`재고 수정 중 오류 발생:`, error);
		alert("재고 수정 중 오류가 발생했습니다. 다시 시도해 주세요.");
	}
}
















// 메인 카테고리 로드
function loadMainCategories() {
	var xhr = new XMLHttpRequest();
	xhr.open("GET", "/mainCategories", true);
	xhr.setRequestHeader("Content-Type", "application/json");

	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4 && xhr.status === 200) {
			var categories = JSON.parse(xhr.responseText);
			var mainCategorySelect = document.querySelector('#mainCategorySelect');
			categories.forEach(function(category) {
				var option = document.createElement('option');
				option.value = category.mainCategoryId;
				option.text = category.mainCategoryName;
				mainCategorySelect.appendChild(option);
			});
		} else if (xhr.readyState === 4) {
			console.error("메인 카테고리 불러오기 중 오류:", xhr.status);
		}
	};
	xhr.send();
}

// 메인 카테고리 변경 시 서브 카테고리 로드
function mainCategoryChange() {
	loadSubCategories();
}

// 서브 카테고리 변경 시 세부 카테고리 로드
function subCategoryChange() {
	loadDetailCategories();
}

// 선택된 메인 카테고리에 따른 서브 카테고리 로드 함수
function loadSubCategories() {
	var mainCategoryId = document.querySelector('#mainCategorySelect').value;

	if (!mainCategoryId) {
		document.querySelector('#subCategorySelect').innerHTML = '<option value="">카테고리를 선택해주세요</option>';
		return;
	}

	var xhr = new XMLHttpRequest();
	xhr.open("GET", "/mainSubCategories?mainCategoryId=" + mainCategoryId, true);
	xhr.setRequestHeader("Content-Type", "application/json");

	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4) {
			if (xhr.status === 200) {
				var subCategories = JSON.parse(xhr.responseText);
				var subCategorySelect = document.querySelector('#subCategorySelect');
				subCategorySelect.innerHTML = '<option value="">2차카테고리 선택</option>'; // 이전 옵션 초기화

				subCategories.forEach(function(subCategory) {
					var option = document.createElement('option');
					option.value = subCategory.subCategoryId;
					option.text = subCategory.subCategoryName;
					subCategorySelect.appendChild(option);
				});

				// 서브 카테고리 로드 후 세부 카테고리 셀렉트 초기화
				document.querySelector('#detailCategorySelect').innerHTML = '<option value="">서브 카테고리를 선택해주세요</option>';
			} else {
				console.error("서브 카테고리 불러오기 중 오류:", xhr.status, xhr.responseText);
				alert("서브 카테고리 불러오기 오류. 관리자에게 문의하세요.");
			}
		}
	};

	xhr.send();
}

// 선택된 서브 카테고리에 따른 세부 카테고리 로드 함수
function loadDetailCategories() {
	var subCategoryId = document.querySelector('#subCategorySelect').value;

	if (!subCategoryId) {
		document.querySelector('#detailCategorySelect').innerHTML = '<option value="">서브 카테고리를 선택해주세요</option>';
		return;
	}

	var xhr = new XMLHttpRequest();
	xhr.open("GET", "/subDetailCategories?subCategoryId=" + subCategoryId, true);
	xhr.setRequestHeader("Content-Type", "application/json");

	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4) {
			if (xhr.status === 200) {
				var detailCategories = JSON.parse(xhr.responseText);
				var detailCategorySelect = document.querySelector('#detailCategorySelect');
				detailCategorySelect.innerHTML = '<option value="">3차카테고리 선택</option>'; // 이전 옵션 초기화

				detailCategories.forEach(function(detailCategory) {
					var option = document.createElement('option');
					option.value = detailCategory.detailCategoryId;
					option.text = detailCategory.detailCategoryName;
					detailCategorySelect.appendChild(option);
				});
			} else {
				console.error("세부 카테고리 불러오기 중 오류:", xhr.status, xhr.responseText);
				alert("세부 카테고리 불러오기 오류. 관리자에게 문의하세요.");
			}
		}
	};

	xhr.send();
}