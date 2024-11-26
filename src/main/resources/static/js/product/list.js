const $productsFilter = $('.products-filter');
const $switchInput = $('.switch-input');
const $switchInputDefault = $('.switch-input').prev();
const $container = $('.prd-list');
const $loadMoreBtn = $('.moreBtn');
let $addItemCount = 24;
let $added = 0;
let $allData = [];
let $filter = $('#product-filter');
let $filterData = [];
let index;

var pcFlag;
var prditemSetpositionFlag;

// 윈도우 불러왔을 때 실행 영역
// 윈도우 불러왔을 때 실행 영역
document.addEventListener("DOMContentLoaded", function() {
	init();

	// URL에서 detailCategoryId 파라미터 추출
	const urlParams = new URLSearchParams(window.location.search);
	const mainCategoryId = urlParams.get('mainCategoryId');
	const subCategoryId = urlParams.get('subCategoryId');
	const detailCategoryId = urlParams.get('detailCategoryId');

	if (detailCategoryId) {
		loadFilterData(detailCategoryId);
	}

	// 색상 필터 컨테이너 이벤트 핸들링
	const colorFilterContainer = document.getElementById('color-filter');
	if (colorFilterContainer) {
		// 이벤트 위임 제거하고, 각 체크박스에 개별 리스너 추가
		colorFilterContainer.addEventListener('click', handleColorFilterEvent);
	}

	// 사이즈 필터 컨테이너 이벤트 핸들링
	const sizeFilterContainer = document.getElementById('size-filter');
	if (sizeFilterContainer) {
		sizeFilterContainer.addEventListener('click', handleSizeFilterEvent);
	}

	// 소재 필터 컨테이너 이벤트 핸들링
	const materialFilterContainer = document.getElementById('material-filter');
	if (materialFilterContainer) {
		materialFilterContainer.addEventListener('click', handleMaterialFilterEvent);
	}

	// 드롭다운 토글 버튼 클릭 시 토글 처리
	const dropdownToggleButton = document.getElementById("dropdown-toggle-button");
	if (dropdownToggleButton) {
		dropdownToggleButton.addEventListener("click", function() {
			const dropdown = document.getElementById('dropdown-colorWithNames');
			const isHidden = dropdown.getAttribute('aria-hidden') === 'true';
			toggleDropdown(!isHidden); // 드롭다운 상태에 따라 토글
		});
	}

	// 전체 카테고리 정보 가져오기 및 브레드크럼 요소 업데이트
	fetchAndUpdateCategories(mainCategoryId, subCategoryId, detailCategoryId);
});

function handleMaterialFilterEvent(event) {
	if (event.target && event.target.matches('.custom-input[type="checkbox"]')) {
		const materialCheckbox = event.target;

		if (materialCheckbox.checked) {
			console.log("선택된 소재:", materialCheckbox.value);
		} else {
			console.log("선택 해제된 소재:", materialCheckbox.value);
		}

		// 선택된 소재들을 리스트로 수집
		const selectedMaterials = Array.from(document.querySelectorAll('#material-filter .custom-input:checked'))
			.map(input => input.value.trim().toLowerCase());

		console.log("선택된 소재 리스트:", selectedMaterials);

		// 선택된 소재에 따른 제품 필터링
		filterProductsByMaterial(selectedMaterials);
	}
}

// 소재 필터링 로직
function filterProductsByMaterial(selectedMaterials) {
	console.log("filterProductsByMaterial() 함수 호출됨");

	// 선택된 소재가 없으면 모든 제품을 표시
	if (!selectedMaterials || selectedMaterials.length === 0) {
		$filterData = $allData;
	} else {
		// 선택된 소재가 있는 경우에만 필터링
		$filterData = $allData.filter(product => {
			if (product.materialList && product.materialList.length > 0) {
				return product.materialList.some(material => {
					const normalizedMaterial = material.trim().toLowerCase();
					return selectedMaterials.includes(normalizedMaterial);
				});
			}
			return false;
		});
	}

	// 필터링된 데이터를 화면에 반영
	$container.empty();
	$added = 0;
	index = 0;
	addItem(true);

	console.log("UI 업데이트 완료 - 제품 항목 갱신됨.");
}

function handleSizeFilterEvent(event) {
	if (event.target && event.target.matches('.custom-input[type="button"]')) {
		const sizeButton = event.target;
		sizeButton.classList.toggle('selected'); // 버튼 선택 여부에 따라 클래스 추가/제거

		// 선택된 사이즈 확인 및 필터링
		const selectedSizes = Array.from(document.querySelectorAll('#size-filter .custom-input.selected'))
			.map(input => input.value.trim().toLowerCase());

		console.log("선택된 사이즈 리스트:", selectedSizes);
		filterProductsBySize(selectedSizes);
	}
}

function filterProductsBySize(selectedSizes) {
	console.log("filterProductsBySize() 함수 호출됨");

	// 선택된 사이즈가 없으면 모든 제품을 표시
	if (!selectedSizes || selectedSizes.length === 0) {
		$filterData = $allData;
	} else {
		// 선택된 사이즈가 있는 경우에만 필터링
		$filterData = $allData.filter(product => {
			if (product.sizeList && product.sizeList.length > 0) {
				return product.sizeList.some(size => {
					const normalizedSize = size.trim().toLowerCase();
					return selectedSizes.includes(normalizedSize);
				});
			}
			return false;
		});
	}

	// 필터링된 데이터를 화면에 반영
	$container.empty();
	$added = 0;
	index = 0;
	addItem(true);

	console.log("UI 업데이트 완료 - 제품 항목 갱신됨.");
}

// 색상 필터 이벤트 핸들러
function handleColorFilterEvent(event) {
	if (event.target && event.target.matches('.custom-input[type="checkbox"]')) {

		// 필터링 로직 호출 (색상을 선택하거나 해제할 때 모두 호출)
		filterProductsByColor();
	}
}


function handleColorFilterChange(event) {
	if (event.target && event.target.matches('.custom-input[type="checkbox"]')) {
		filterProductsByColor();
	}
}

function toggleDropdownVisibility() {
	const dropdown = document.getElementById('dropdown-colorWithNames');
	const isHidden = dropdown.getAttribute('aria-hidden') === 'true';
	toggleDropdown(!isHidden);
}

function fetchAndUpdateCategories(mainCategoryId, subCategoryId, detailCategoryId) {
	axios.get(`/views/categoriesPage`)
		.then(response => {
			const categories = response.data;

			let mainCategoryName = "";
			let subCategoryName = "";
			let detailCategoryName = "";

			categories.forEach(category => {
				if (category.mainCategoryId == mainCategoryId) {
					mainCategoryName = category.mainCategoryName;
				}
				if (category.subCategoryId == subCategoryId) {
					subCategoryName = category.subCategoryName;
				}
				if (category.detailCategoryId == detailCategoryId) {
					detailCategoryName = category.detailCategoryName;
				}
			});

			updateBreadcrumb(mainCategoryName, subCategoryName, detailCategoryName);
		})
		.catch(error => {
			console.error('카테고리 정보를 가져오는 데 실패했습니다:', error);
		});
}

function updateBreadcrumb(mainCategoryName, subCategoryName, detailCategoryName) {
	const mainCategoryElement = document.querySelector('.breadcrumb-item:first-child');
	const subCategoryElement = document.querySelector('.breadcrumb-item:nth-child(2)');
	const detailCategoryElement = document.querySelector('.breadcrumb-item.active');

	if (mainCategoryName && mainCategoryElement) {
		mainCategoryElement.textContent = mainCategoryName;
	}

	if (subCategoryName && subCategoryElement) {
		subCategoryElement.textContent = subCategoryName;
		subCategoryElement.classList.add('hidden');
	}

	if (detailCategoryName && detailCategoryElement) {
		detailCategoryElement.textContent = detailCategoryName;
		detailCategoryElement.classList.remove('hidden');
	}
}


// 드롭다운 토글 버튼 클릭 시 토글 처리
const dropdownToggleButton = document.getElementById("dropdown-toggle-button");
if (dropdownToggleButton) {
	dropdownToggleButton.addEventListener("click", function() {
		const dropdown = document.getElementById('dropdown-colorWithNames');
		const isHidden = dropdown.getAttribute('aria-hidden') === 'true';
		toggleDropdown(!isHidden); // 드롭다운 상태에 따라 토글
	});
}

const urlParams = new URLSearchParams(window.location.search);
const mainCategoryId = urlParams.get('mainCategoryId');
const subCategoryId = urlParams.get('subCategoryId');
const detailCategoryId = urlParams.get('detailCategoryId');


// 드롭다운을 열거나 닫는 함수
function toggleDropdown(show) {
	const dropdown = document.getElementById('dropdown-colorWithNames');
	if (show) {
		dropdown.style.display = 'block';
		dropdown.setAttribute('aria-hidden', 'false'); // 드롭다운 열기
	} else {
		dropdown.style.display = 'none';
		dropdown.setAttribute('aria-hidden', 'true'); // 드롭다운 닫기
	}
}

// 필터링 로직 함수
function filterProductsByColor() {

	// 체크된 체크박스에서 선택된 색상 가져오기
	const checkedColors = Array.from(document.querySelectorAll('#color-filter .custom-input:checked'))
		.map(input => input.value.trim().toLowerCase());

	// 선택된 색상이 없으면 모든 제품을 표시
	if (checkedColors.length === 0) {
		$filterData = $allData;
	} else {
		// 선택된 색상에 따라 제품 필터링
		$filterData = $allData.filter(product => {
			// 제품의 색상 리스트와 매칭하기 위해 colorList와 productImgs 둘 다 확인
			const hasMatchingColorList = product.colorList.some(color => {
				const normalizedColor = color.trim().toLowerCase();
				return checkedColors.includes(normalizedColor);
			});

			const hasMatchingProductImgColor = product.productImgs.some(img => {
				if (img.colorName) {
					const imgColor = img.colorName.trim().toLowerCase();
					return checkedColors.includes(imgColor);
				}
				return false;
			});

			// colorList 또는 productImgs 중 하나라도 매칭되면 true
			return hasMatchingColorList || hasMatchingProductImgColor;
		});
	}


	// 제품 목록을 갱신
	$container.empty();
	$added = 0;
	index = 0;
	addItem(true);
}

function init() {
	const urlParams = new URLSearchParams(window.location.search);
	const detailCategoryId = urlParams.get('detailCategoryId');


	checkDevice();
	fliterSwitch(); // 필터 모바일 피씨 디자인 변경
	loadProducts(detailCategoryId);

	if (pcFlag && !prditemSetpositionFlag) {
		index = 0;
		prditemSetposition2();
	}
	$loadMoreBtn.hide();
}

function prditemSetposition2() {
	$added = $(".prd-item").length;
	$(".prd-item").each(function(i) {
		let $this = $(this);
		if (i > index && i < $added) {
			let position;
			position = $this.offset();
			position = position.left - 24;
			if ($this.hasClass('prd-item-large')) {
				if (position > 0) {
					$this.prev().addClass('space');
				} else {
					$this.addClass('space');
				}
			}
		}
	});
	prditemSetpositionFlag = true;
}

function filterItems() {
	let checked = $(this).is(':checked');
	let key = $(this).val();
	$filterData = [];
	$added = 0;
	$container.empty();
	if (checked == false) {
		$filterData = $allData;
	} else {
		$filterData = $.grep($allData, function(item) {
			return item.line === key;
		});
	}
	index = 0;  //data 처음부터 부른다는 의미
	$('.space').removeClass('space');
	addItem(true);
}

// 필터 버튼 동작
$('.filterNavButton').click(function() {
	$('#filterBox').addClass('block');
	$('#filterBox').removeClass('flex');
	$('#filterBox').removeClass('hide');
	$(this).addClass('clicked');
	$('html').css('overflow', 'hidden');
	return false;
});

$('#filterClose .nav-close').click(function() {
	$('#filterBox').removeClass('block');
	$('#filterBox').addClass('hide');
	$('.filterNavButton').removeClass('clicked');
	$('html').css('overflow', 'scroll');
	return false;
});

// 한줄 보기, 두줄 보기 설정
$('#oneVisibleBtn').click(function() {
	$('.prd-list').addClass('oneLine');
	$('.prd-list').removeClass('twoLine');
	$('#one').prop('checked', true);
	$('#two').prop('checked', false);
	return false;
});

$('#twoVisibleBtn').click(function() {
	$('.prd-list').removeClass('oneLine');
	$('.prd-list').addClass('twoLine');
	$('#one').prop('checked', false);
	$('#two').prop('checked', true);
	return false;
});

// 스위치 입력 클릭 시 기본 입력 클릭
$switchInput.click(function() {
	$switchInputDefault.click();
});

// 드롭다운 버튼 동작
$('.dropdown-btn').click(function(e) {
	if (!$(this).hasClass('open')) {
		$('.dropdown-btn.open').removeClass('open');
		$('.dropdown.open').removeClass('open');
		$('.dropdown').hide();
	}
	$(this).toggleClass('open');
	$(this).next().slideToggle(100);
	e.preventDefault();
});

// 사이즈 선택 버튼 동작
$('.custom-input[type=button]').click(function() {
	$(this).toggleClass('checked');
	return false;
});

// 서버에서 제품 데이터를 가져오는 함수
function loadProducts(detailCategoryId) {
	let url = '/products';
	if (detailCategoryId) {
		url += `?piDetailCategoryId=${detailCategoryId}`;
	}


	$.getJSON(url, function(data) {
		$allData = data;
		$filterData = $allData;
		addItem();
		$loadMoreBtn.click(function() {
			addItem();
		});
	}).fail(function() {
		console.error('제품 데이터를 불러오는 중 오류 발생.');
	});
}

// 제품 아이템 추가 함수
function addItem(isInitialLoad) {
	let element = [];
	const previousAdded = $added;
	$added += $addItemCount;
	const slicedData = $filterData.slice(previousAdded, $added);

	$.each(slicedData, function(index, item) {

		// 첫 번째 이미지를 기본으로 표시
		let imgSrc = item.productImgs && item.productImgs[0] && item.productImgs[0].pimgUrl
			? '/uploads/' + item.productImgs[0].pimgUrl
			: '/uploads/product/images/defalt-image.jpg';

		let itemHTML = `
            <a href="/views/product/detail?piId=${item.piId}" class="prd-item">
                <div class="prd-image">
                    <img src="${imgSrc}" alt="${item.piName}">
                </div>
                <div class="prd-meta">
                    <p class="prd-name">${item.piName}</p>
                    <p class="prd-price"><span class="sr-only">, </span>₩ ${Number(item.piPrice).toLocaleString()}</p>
                </div>
            </a>
        `;

		element.push($(itemHTML).get(0));
	});

	if ($added < $filterData.length) {
		$loadMoreBtn.show();
	} else {
		$loadMoreBtn.remove();
	}

	$container.append(element);

	setTimeout(function() {
		if (pcFlag) {
			prditemSetposition(); // addItem 했을 때 정렬하는 곳. 피씨면 정렬한다.
		} else {
			console.log("모바일 환경에서 space 제거");
			$('.prd-item').removeClass('space'); // 모바일이면 space를 다 뺀다.
		}
	}, 100);
}

function checkDevice() {
	if ($(window).width() > 802) {
		pcFlag = true;
	} else {
		pcFlag = false;
	}
}

function prditemSetposition() {
	$('.prd-item').each(function(i) {
		let $this = $(this);
		if (i > index && i < $added) {
			let position;
			position = $this.offset();
			position = position.left - 24;
			if ($this.hasClass('prd-item-large')) {
				if (position > 0) {
					$this.prev().addClass('space');
				} else {
					$this.addClass('space');
				}
			}
		}
	});
	prditemSetpositionFlag = true;
}

function fliterSwitch() {
	if (!pcFlag) {
		$productsFilter.addClass('mobile');
		$('#filterBox').removeClass('flex');
		if ($('.filterNavButton').hasClass('clicked')) {
			$('#filterBox').addClass('block');
		} else {
			$('#filterBox').addClass('hide');
		}
	} else {
		if ($('.filterNavButton').hasClass('clicked')) {
			$('#filterBox').removeClass('block');
		}
		$('#filterBox').removeClass('hide');
		$productsFilter.removeClass('mobile');
		$('#filterBox').addClass('flex');
	}
}


// 필터 데이터를 불러오는 함수
function loadFilterData(detailCategoryId) {
	// 색상 필터 데이터를 불러오기
	axios.get(`/productColors/filterItemCount?detailCategoryId=${detailCategoryId}`)
		.then(response => {
			const colors = response.data;
			const colorFilterContainer = document.getElementById('color-filter');

			// 기존 내용 삭제
			if (colorFilterContainer) {
				colorFilterContainer.innerHTML = '';

				// 모든 색상 옵션을 불러오기 위해 추가로 요청
				axios.get('/productColors')
					.then(allColorsResponse => {
						const allColors = allColorsResponse.data;

						allColors.forEach(color => {
							const matchingColor = colors.find(c => c.pcId === color.pcId);
							const itemCount = matchingColor ? matchingColor.itemCount : 0;

							const colorItem = `
                                <li class="inputwrapper">
                                    <input class="custom-input" type="checkbox" data-name="colorWithNames"
                                        name="dropdown-colorWithNames" id="dropdown-colorWithNames-${color.pcName}" value="${color.pcName}">
                                    <label class="label" for="dropdown-colorWithNames-${color.pcName}">
                                        <span class="item-color" style="background:${color.pcCode};"></span>
                                        <span class="text">${color.pcName}</span>
                                        <span class="item-count">${itemCount}</span>
                                    </label>
                                </li>`;
							colorFilterContainer.insertAdjacentHTML('beforeend', colorItem);
						});
					})
					.catch(error => {
						console.error('모든 색상 데이터를 불러오는 중 오류 발생:', error);
					});
			}
		})
		.catch(error => {
			console.error('필터 데이터를 불러오는 중 오류 발생:', error);
		});

	// 소재 필터 데이터를 불러오기
	axios.get(`/productMaterials/filterItemCount?detailCategoryId=${detailCategoryId}`)
		.then(response => {
			const materials = response.data;
			const materialFilterContainer = document.getElementById('material-filter');

			// 기존 내용 삭제
			if (materialFilterContainer) {
				materialFilterContainer.innerHTML = '';

				// 모든 소재 옵션을 불러오기 위해 추가로 요청
				axios.get('/productMaterials')
					.then(allMaterialsResponse => {
						const allMaterials = allMaterialsResponse.data;

						allMaterials.forEach(material => {
							const matchingMaterial = materials.find(m => m.pmId === material.pmId);
							const itemCount = matchingMaterial ? matchingMaterial.itemCount : 0;

							const materialItem = `
		                                <li class="inputwrapper">
		                                    <input class="custom-input" type="checkbox" data-name="materials"
		                                        name="dropdown-materials" id="dropdown-materials-${material.pmName}" value="${material.pmName}">
		                                    <label class="label" for="dropdown-materials-${material.pmName}">
		                                        <span class="text">${material.pmName}</span>
		                                        <span class="item-count">${itemCount}</span>
		                                    </label>
		                                </li>`;
							materialFilterContainer.insertAdjacentHTML('beforeend', materialItem);
						});
					})
					.catch(error => {
						console.error('모든 소재 데이터를 불러오는 중 오류 발생:', error);
					});
			}
		})
		.catch(error => {
			console.error('소재 필터 데이터를 불러오는 중 오류 발생:', error);
		});

	// 사이즈 필터 데이터를 불러오기
	axios.get('/productSizes')
		.then(response => {
			const sizes = response.data;
			const sizeFilterContainer = document.getElementById('size-filter');

			// 기존 내용 삭제
			sizeFilterContainer.innerHTML = '';

			// 새 필터 항목 추가
			sizes.forEach(size => {
				const sizeItem = `
					<li class="inputwrapper">
					<input class="custom-input" type="button" data-name="size" name="dropdown-size" id="dropdown-size-${size.psName}" value="${size.psName}">
					</li>`;
				sizeFilterContainer.insertAdjacentHTML('beforeend', sizeItem);
			});
		})
		.catch(error => {
			console.error('필터 데이터를 불러오는 중 오류 발생:', error);
		});

}