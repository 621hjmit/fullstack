// DOMContentLoaded 이벤트 사용하여 모든 요소가 로드된 후 코드 실행
document.addEventListener("DOMContentLoaded", function () {
    const addCategorySelect = document.getElementById("addCategorySelect");
    const dynamicInputsContainer = document.getElementById("dynamicInputsContainer");
    const addCategoryBtn = document.getElementById("addCategoryBtn");

    // 카테고리 선택 시 동적으로 UI 변경
    addCategorySelect.addEventListener("change", function () {
        const selectedValue = addCategorySelect.value;

        // 동적 입력 필드 컨테이너 초기화
        dynamicInputsContainer.innerHTML = "";

        if (selectedValue === "1") {
            // 1차 카테고리 선택 시
            const input = document.createElement("input");
            input.type = "text";
            input.className = "form-control mt-2";
            input.placeholder = "새로운 1차 카테고리 이름 입력";
            input.id = "newMainCategoryName";
            dynamicInputsContainer.appendChild(input);
            addCategoryBtn.style.display = "block";
        } else if (selectedValue === "2") {
            // 2차 카테고리 선택 시
            const mainCategorySelect = document.createElement("select");
            mainCategorySelect.className = "form-select mt-2";
            mainCategorySelect.id = "dynamicMainCategorySelect"; // 동적 요소로 유일한 ID 설정
            dynamicInputsContainer.appendChild(mainCategorySelect);

            // 메인 카테고리 데이터를 불러와서 옵션으로 추가
            loadMainCategoriesToSelect(mainCategorySelect);

            const input = document.createElement("input");
            input.type = "text";
            input.className = "form-control mt-2";
            input.placeholder = "새로운 2차 카테고리 이름 입력";
            input.id = "newSubCategoryName";
            dynamicInputsContainer.appendChild(input);
            addCategoryBtn.style.display = "block";
        } else if (selectedValue === "3") {
            // 3차 카테고리 선택 시
            const mainCategorySelect = document.createElement("select");
            mainCategorySelect.className = "form-select mt-2";
            mainCategorySelect.id = "dynamicMainCategorySelect"; // 동적 요소로 유일한 ID 설정
            dynamicInputsContainer.appendChild(mainCategorySelect);

            // 메인 카테고리 데이터를 불러와서 옵션으로 추가
            loadMainCategoriesToSelect(mainCategorySelect);

            const subCategorySelect = document.createElement("select");
            subCategorySelect.className = "form-select mt-2";
            subCategorySelect.id = "dynamicSubCategorySelect"; // 동적 요소로 유일한 ID 설정
            dynamicInputsContainer.appendChild(subCategorySelect);

            // 메인 카테고리 선택 시, 서브 카테고리를 로드하는 이벤트 추가
            mainCategorySelect.addEventListener("change", function () {
                const mainCategoryId = mainCategorySelect.value;
                if (mainCategoryId) {
                    loadSubCategoriesToSelect(mainCategoryId, subCategorySelect);
                } else {
                    subCategorySelect.innerHTML = '<option value="">메인 카테고리를 선택해주세요</option>';
                }
            });

            const input = document.createElement("input");
            input.type = "text";
            input.className = "form-control mt-2";
            input.placeholder = "새로운 3차 카테고리 이름 입력";
            input.id = "newDetailCategoryName";
            dynamicInputsContainer.appendChild(input);
            addCategoryBtn.style.display = "block";
        } else {
            // 아무 것도 선택되지 않은 경우 버튼 숨김
            addCategoryBtn.style.display = "none";
        }
    });

    // 카테고리 추가 버튼 클릭 이벤트
    addCategoryBtn.addEventListener("click", function () {
        const selectedCategoryLevel = addCategorySelect.value;

        if (selectedCategoryLevel === "1") {
            const categoryName = document.getElementById("newMainCategoryName")?.value.trim();
            if (!categoryName) {
                alert("카테고리 이름을 입력하세요.");
                return;
            }

            // 메인 카테고리 추가 함수 호출
            addMainCategory(categoryName);
        } else if (selectedCategoryLevel === "2") {
            const mainCategorySelect = document.getElementById("dynamicMainCategorySelect"); // 동적으로 생성된 select 요소
            const subCategoryName = document.getElementById("newSubCategoryName")?.value.trim();

            console.log("1차 카테고리 선택 상태:", mainCategorySelect ? mainCategorySelect.value : "없음");

            if (!mainCategorySelect || !mainCategorySelect.value) {
                alert("1차 카테고리를 선택해주세요.");
                return;
            }
            if (!subCategoryName) {
                alert("2차 카테고리 이름을 입력하세요.");
                return;
            }

            const mainCategoryId = mainCategorySelect.value;

            // 서브 카테고리 추가 함수 호출
            addSubCategory(mainCategoryId, subCategoryName);
        } else if (selectedCategoryLevel === "3") {
            const mainCategorySelect = document.getElementById("dynamicMainCategorySelect");
            const subCategorySelect = document.getElementById("dynamicSubCategorySelect");
            const detailCategoryName = document.getElementById("newDetailCategoryName")?.value.trim();

            console.log("1차 카테고리 선택 상태:", mainCategorySelect ? mainCategorySelect.value : "없음");
            console.log("2차 카테고리 선택 상태:", subCategorySelect ? subCategorySelect.value : "없음");

            if (!mainCategorySelect || !mainCategorySelect.value) {
                alert("1차 카테고리를 선택해주세요.");
                return;
            }
            if (!subCategorySelect || !subCategorySelect.value) {
                alert("2차 카테고리를 선택해주세요.");
                return;
            }
            if (!detailCategoryName) {
                alert("3차 카테고리 이름을 입력하세요.");
                return;
            }

            const mainCategoryId = mainCategorySelect.value;
            const subCategoryId = subCategorySelect.value;

            // 세부 카테고리 추가 함수 호출
            addDetailCategory(mainCategoryId, subCategoryId, detailCategoryName);
        }
    });
});


// 특정 select 요소에 메인 카테고리를 로드하는 함수
function loadMainCategoriesToSelect(selectElement) {
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "/mainCategories", true);
    xhr.setRequestHeader("Content-Type", "application/json");

    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var categories = JSON.parse(xhr.responseText);
            if (!Array.isArray(categories)) {
                console.error("유효하지 않은 데이터 형식입니다.", categories);
                return;
            }

            // select 요소 초기화
            selectElement.innerHTML = '<option value="">1차 카테고리 선택</option>';

            // 각 카테고리를 select 요소에 추가
            categories.forEach(function (category) {
                var option = document.createElement("option");
                option.value = category.mainCategoryId;
                option.text = category.mainCategoryName;
                selectElement.appendChild(option);
            });
        } else if (xhr.readyState === 4) {
            console.error("메인 카테고리 불러오기 중 오류:", xhr.status);
        }
    };
    xhr.send();
}

// 특정 select 요소에 서브 카테고리를 로드하는 함수
function loadSubCategoriesToSelect(mainCategoryId, selectElement) {
    if (!mainCategoryId) {
        selectElement.innerHTML = '<option value="">메인 카테고리를 선택해주세요</option>';
        return;
    }

    var xhr = new XMLHttpRequest();
    xhr.open("GET", "/mainSubCategories?mainCategoryId=" + mainCategoryId, true);
    xhr.setRequestHeader("Content-Type", "application/json");

    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            try {
                var subCategories = JSON.parse(xhr.responseText);
                if (!Array.isArray(subCategories)) {
                    console.error("유효하지 않은 데이터 형식입니다.", subCategories);
                    return;
                }

                // select 요소 초기화
                selectElement.innerHTML = '<option value="">2차 카테고리 선택</option>';

                // 각 서브 카테고리를 select 요소에 추가
                subCategories.forEach(function (subCategory) {
                    var option = document.createElement("option");
                    option.value = subCategory.subCategoryId;
                    option.text = subCategory.subCategoryName;
                    selectElement.appendChild(option);
                });
            } catch (e) {
                console.error("응답 파싱 중 오류 발생:", e.message);
            }
        } else if (xhr.readyState === 4) {
            console.error("서브 카테고리 불러오기 중 오류:", xhr.status, xhr.responseText);
        }
    };
    xhr.send();
}


// 메인 카테고리 로드
function loadMainCategories() {
	var xhr = new XMLHttpRequest();
	xhr.open("GET", "/mainCategories", true);
	xhr.setRequestHeader("Content-Type", "application/json");

	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4 && xhr.status === 200) {
			var categories = JSON.parse(xhr.responseText);
			var mainCategorySelect = document.getElementById('mainCategorySelect');
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

function loadSubCategories(mainCategoryId) {
	if (!mainCategoryId) {
		mainCategoryId = document.getElementById('mainCategorySelect').value;
	}

	if (!mainCategoryId) {
		document.getElementById('subCategorySelect').innerHTML = '<option value="">메인 카테고리를 선택해주세요</option>';
		return;
	}

	var xhr = new XMLHttpRequest();
	xhr.open("GET", "/mainSubCategories?mainCategoryId=" + mainCategoryId, true);
	xhr.setRequestHeader("Content-Type", "application/json");

	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4 && xhr.status === 200) {
			try {
				var subCategories = JSON.parse(xhr.responseText);
				if (!Array.isArray(subCategories)) {
					console.error("유효하지 않은 데이터 형식입니다.", subCategories);
					return;
				}

				var subCategorySelect = document.getElementById('subCategorySelect');
				const previouslySelectedValue = subCategorySelect.value; // 현재 선택된 서브 카테고리 값을 저장

				subCategorySelect.innerHTML = '<option value="">2차 카테고리 선택</option>'; // 이전 옵션 초기화

				subCategories.forEach(function(subCategory) {
					var option = document.createElement('option');
					option.value = subCategory.subCategoryId;
					option.text = subCategory.subCategoryName;
					subCategorySelect.appendChild(option);
				});

				// 이전에 선택한 값을 다시 선택하도록 설정
				if (previouslySelectedValue) {
					subCategorySelect.value = previouslySelectedValue;
				}

				// 서브 카테고리 로드 후 세부 카테고리 셀렉트 초기화
				document.getElementById('detailCategorySelect').innerHTML = '<option value="">서브 카테고리를 선택해주세요</option>';

				// 서브 카테고리 데이터를 테이블에 추가
				displaySubCategories(subCategories);
			} catch (e) {
				console.error("응답 파싱 중 오류 발생:", e.message);
			}
		} else if (xhr.readyState === 4) {
			console.error("서브 카테고리 불러오기 중 오류:", xhr.status, xhr.responseText);
			alert("서브 카테고리 불러오기 오류. 관리자에게 문의하세요.");
		}
	};

	xhr.send();
}

// 선택된 서브 카테고리에 따른 세부 카테고리 로드 함수
function loadDetailCategories() {
	var subCategoryId = document.getElementById('subCategorySelect').value;

	if (!subCategoryId) {
		document.getElementById('detailCategorySelect').innerHTML = '<option value="">서브 카테고리를 선택해주세요</option>';
		return;
	}

	var xhr = new XMLHttpRequest();
	xhr.open("GET", "/subDetailCategories?subCategoryId=" + subCategoryId, true);
	xhr.setRequestHeader("Content-Type", "application/json");

	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4) {
			if (xhr.status === 200) {
				try {
					var detailCategories = JSON.parse(xhr.responseText);
					if (!Array.isArray(detailCategories)) {
						console.error("유효하지 않은 데이터 형식입니다.", detailCategories);
						return;
					}

					var detailCategorySelect = document.getElementById('detailCategorySelect');
					const previouslySelectedValue = detailCategorySelect.value; // 현재 선택된 세부 카테고리 값을 저장

					// 이전 옵션 초기화
					detailCategorySelect.innerHTML = '<option value="">3차 카테고리 선택</option>';

					// 새로운 데이터 추가
					detailCategories.forEach(function(detailCategory) {
						var option = document.createElement('option');
						option.value = detailCategory.detailCategoryId;
						option.text = detailCategory.detailCategoryName;
						detailCategorySelect.appendChild(option);
					});

					// 이전에 선택한 값을 다시 선택하도록 설정 (있는 경우)
					if (previouslySelectedValue) {
						detailCategorySelect.value = previouslySelectedValue;
					}

					// 추가된 로그로 데이터 확인
					console.log("로드된 3차 카테고리 데이터:", detailCategories);

				} catch (e) {
					console.error("응답 파싱 중 오류 발생:", e.message);
				}
			} else {
				console.error("세부 카테고리 불러오기 중 오류:", xhr.status, xhr.responseText);
				alert("세부 카테고리 불러오기 오류. 관리자에게 문의하세요.");
			}
		}
	};

	xhr.send();
}


// 1차 카테고리 변경 시 서브 카테고리 로드 및 버튼 이동
function mainCategoryChange() {
	loadSubCategories(); // 서브 카테고리 로드

	// 모든 액션 버튼 초기화
	resetAllActions();

	// 메인 카테고리 관련 수정/삭제 버튼 이동
	moveActions('mainCategorySelect', 'mainCategoryActions', editMainCategory, deleteMainCategory);

	// 서브 카테고리와 세부 카테고리 초기화
	document.getElementById("subCategorySelect").value = "";
	document.getElementById("detailCategorySelect").value = "";
}

// 2차 카테고리 변경 시 세부 카테고리 로드 및 버튼 이동
function subCategoryChange() {
	// 서브 카테고리 선택 시, 해당 서브 카테고리의 하위 세부 카테고리 로드
	var subCategoryId = document.getElementById('subCategorySelect').value;

	if (!subCategoryId) {
		// 서브 카테고리가 선택되지 않은 경우 테이블을 초기화하고 종료
		document.getElementById('categoryTableBody').innerHTML = '';
		return;
	}

	loadDetailCategoriesWithCallback(subCategoryId, function(detailCategories) {
		// 모든 액션 버튼 초기화
		resetAllActions();

		// 서브 카테고리 관련 수정/삭제 버튼 이동
		moveActions('subCategorySelect', 'subCategoryActions', editSubCategory, deleteSubCategory);

		// 선택된 서브 카테고리 데이터를 테이블에 표시
		const subCategorySelect = document.getElementById('subCategorySelect');
		const selectedSubCategoryId = subCategorySelect.value;

		if (selectedSubCategoryId) {
			const selectedOption = subCategorySelect.querySelector(`option[value="${selectedSubCategoryId}"]`);
			if (selectedOption) {
				// 서브 카테고리와 세부 카테고리를 테이블에 표시
				displaySubCategoriesWithDetails(detailCategories, {
					subCategoryId: selectedSubCategoryId,
					subCategoryName: selectedOption.text
				});
			}
		}
	});
}

// 세부 카테고리 로드 후 콜백 함수 호출 (세부 카테고리 데이터를 사용해 작업 수행)
function loadDetailCategoriesWithCallback(subCategoryId, callback) {
	if (!subCategoryId) {
		document.getElementById('detailCategorySelect').innerHTML = '<option value="">서브 카테고리를 선택해주세요</option>';
		return;
	}

	var xhr = new XMLHttpRequest();
	xhr.open("GET", "/subDetailCategories?subCategoryId=" + subCategoryId, true);
	xhr.setRequestHeader("Content-Type", "application/json");

	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4) {
			if (xhr.status === 200) {
				try {
					var detailCategories = JSON.parse(xhr.responseText);
					if (!Array.isArray(detailCategories)) {
						console.error("유효하지 않은 데이터 형식입니다.", detailCategories);
						return;
					}

					var detailCategorySelect = document.getElementById('detailCategorySelect');
					const previouslySelectedValue = detailCategorySelect.value; // 현재 선택된 세부 카테고리 값을 저장

					// 이전 옵션 초기화
					detailCategorySelect.innerHTML = '<option value="">3차 카테고리 선택</option>';

					// 새로운 데이터 추가
					detailCategories.forEach(function(detailCategory) {
						var option = document.createElement('option');
						option.value = detailCategory.detailCategoryId;
						option.text = detailCategory.detailCategoryName;
						detailCategorySelect.appendChild(option);
					});

					// 이전에 선택한 값을 다시 선택하도록 설정 (있는 경우)
					if (previouslySelectedValue) {
						detailCategorySelect.value = previouslySelectedValue;
					}

					// 추가된 로그로 데이터 확인
					console.log("로드된 3차 카테고리 데이터:", detailCategories);

					// 콜백 함수 호출
					if (callback) {
						callback(detailCategories);
					}

				} catch (e) {
					console.error("응답 파싱 중 오류 발생:", e.message);
				}
			} else {
				console.error("세부 카테고리 불러오기 중 오류:", xhr.status, xhr.responseText);
				alert("세부 카테고리 불러오기 오류. 관리자에게 문의하세요.");
			}
		}
	};

	xhr.send();
}


// 3차 카테고리 변경 시 버튼 이동
function detailCategoryChange() {
	console.log("detailCategoryChange 함수가 호출되었습니다.");

	// 모든 액션 버튼 초기화
	resetAllActions();

	// 세부 카테고리 관련 수정/삭제 버튼 이동
	moveActions('detailCategorySelect', 'detailCategoryActions', editDetailCategory, deleteDetailCategory);

	// 선택된 3차 카테고리 ID를 로그로 출력
	var detailCategorySelect = document.getElementById('detailCategorySelect');
	var selectedDetailCategoryId = detailCategorySelect.value;

	if (selectedDetailCategoryId) {
		// 3차 카테고리 데이터 로드 및 테이블에 반영
		loadDetailCategories();

		// 선택된 3차 카테고리를 테이블에 표시
		const selectedOption = detailCategorySelect.querySelector(`option[value="${selectedDetailCategoryId}"]`);
		if (selectedOption) {
			displayDetailCategories([{
				detailCategoryId: selectedDetailCategoryId,
				detailCategoryName: selectedOption.text
			}]);
		}
	}
}

// 모든 액션 버튼을 초기화하는 함수
function resetAllActions() {
	document.getElementById("mainCategoryActions").innerHTML = "";
	document.getElementById("subCategoryActions").innerHTML = "";
	document.getElementById("detailCategoryActions").innerHTML = "";
}

// 버튼을 동적으로 이동시키는 함수
function moveActions(categorySelectId, actionContainerId, editFunction, deleteFunction) {
	resetAllActions();

	const categorySelect = document.getElementById(categorySelectId);
	const actionContainer = document.getElementById(actionContainerId);

	if (!categorySelect) {
		console.error("카테고리 셀렉트 요소를 찾을 수 없습니다: " + categorySelectId);
		return;
	}

	if (!actionContainer) {
		console.error("액션 컨테이너 요소를 찾을 수 없습니다: " + actionContainerId);
		return;
	}

	if (categorySelect.value) {
		// 수정 버튼 추가
		const editBtn = document.createElement("button");
		editBtn.className = "btn btn-primary me-2 mt-3";
		editBtn.textContent = "수정";
		editBtn.onclick = function() {
			const selectedValue = categorySelect.value;
			const newCategoryName = editFunction(selectedValue);

			if (newCategoryName) {
				// 드롭다운과 테이블에 새로운 이름 반영
				updateCategoryDisplay(categorySelectId, selectedValue, newCategoryName);

				if (categorySelectId === 'mainCategorySelect') {
					loadSubCategories(selectedValue);
				} else if (categorySelectId === 'subCategorySelect') {
					loadDetailCategories();
				}
			}
		};

		// 삭제 버튼 추가
		const deleteBtn = document.createElement("button");
		deleteBtn.className = "btn btn-danger me-2 mt-3";
		deleteBtn.textContent = "삭제";
		deleteBtn.onclick = function() {
			deleteFunction(categorySelect.value);
		};

		// 초기화 버튼 추가
		const resetBtn = document.createElement("button");
		resetBtn.className = "btn btn-secondary mt-3";
		resetBtn.textContent = "초기화";
		resetBtn.onclick = function() {
			location.reload();
		};

		// 버튼을 컨테이너에 추가
		const buttonContainer = document.createElement("div");
		buttonContainer.style.marginTop = "15px";
		buttonContainer.appendChild(editBtn);
		buttonContainer.appendChild(deleteBtn);
		buttonContainer.appendChild(resetBtn);

		actionContainer.appendChild(buttonContainer);
	}
}


// 수정된 데이터를 화면에 반영하는 함수
function updateCategoryDisplay(categorySelectId, selectedCategoryId, newCategoryName) {
	const categorySelect = document.getElementById(categorySelectId);
	if (!categorySelect) {
		console.error("카테고리 셀렉트 요소를 찾을 수 없습니다: " + categorySelectId);
		return;
	}

	// 드롭다운 옵션 업데이트
	const selectedOption = categorySelect.querySelector(`option[value="${selectedCategoryId}"]`);
	if (selectedOption) {
		selectedOption.text = newCategoryName;
	} else {
		console.error("선택한 카테고리를 찾을 수 없습니다.");
	}

	// 테이블 데이터 업데이트 (예: 수정된 이름을 테이블에 반영)
	const tableRows = document.querySelectorAll("table tr");
	tableRows.forEach((row) => {
		const categoryIdCell = row.querySelector(".category-id-cell");
		const categoryCell = row.querySelector(".category-name-cell");

		if (categoryIdCell && categoryCell && categoryIdCell.textContent == selectedCategoryId) {
			categoryCell.textContent = newCategoryName; // 수정된 이름으로 업데이트
		}
	});
}




// 메인 카테고리를 테이블에 표시하는 함수
function displayMainCategory() {
	var categoryTableBody = document.getElementById('categoryTableBody');
	categoryTableBody.innerHTML = ''; // 기존 테이블 초기화

	// 선택된 메인 카테고리 정보 가져오기
	var mainCategorySelect = document.getElementById('mainCategorySelect');
	var selectedIndex = mainCategorySelect.selectedIndex;

	if (selectedIndex <= 0) {
		return; // 아무것도 선택되지 않은 경우 종료
	}

	var mainCategoryName = mainCategorySelect.options[selectedIndex].text;

	var row = document.createElement('tr');
	row.classList.add('text-center');

	var mainCategoryCell = document.createElement('th');
	mainCategoryCell.scope = 'row';
	mainCategoryCell.innerText = mainCategoryName;

	var subCategoryCell = document.createElement('td');
	subCategoryCell.innerText = ''; // 서브 카테고리 빈 값

	var detailCategoryCell = document.createElement('td');
	detailCategoryCell.innerText = ''; // 세부 카테고리 빈 값

	row.appendChild(mainCategoryCell);
	row.appendChild(subCategoryCell);
	row.appendChild(detailCategoryCell);

	categoryTableBody.appendChild(row);
}

// 서브 카테고리 데이터를 테이블에 추가 (세부 카테고리도 함께 표시)
function displaySubCategories(subCategories) {
	var categoryTableBody = document.getElementById('categoryTableBody');
	categoryTableBody.innerHTML = ''; // 기존 테이블 초기화

	// 선택된 메인 카테고리 정보 가져오기
	var mainCategorySelect = document.getElementById('mainCategorySelect');
	var selectedMainCategoryId = mainCategorySelect.value;
	var selectedMainCategoryName = mainCategorySelect.options[mainCategorySelect.selectedIndex].text;

	subCategories.forEach(function(subCategory) {
		var row = document.createElement('tr');
		row.classList.add('text-center');

		// 메인 카테고리 정보 셀 추가
		var mainCategoryCell = document.createElement('th');
		mainCategoryCell.scope = 'row';
		mainCategoryCell.innerText = selectedMainCategoryName;

		// 서브 카테고리 정보 셀 추가
		var subCategoryCell = document.createElement('td');
		subCategoryCell.innerText = subCategory.subCategoryName;

		// 세부 카테고리 셀은 아직 선택되지 않았으므로 빈 값으로 시작
		var detailCategoryCell = document.createElement('td');
		detailCategoryCell.innerText = '';

		row.appendChild(mainCategoryCell);
		row.appendChild(subCategoryCell);
		row.appendChild(detailCategoryCell);

		categoryTableBody.appendChild(row);
	});
}
// 세부 카테고리 데이터를 테이블에 추가 (선택된 카테고리만 표시)
function displayDetailCategories(detailCategories) {
	var categoryTableBody = document.getElementById('categoryTableBody');
	categoryTableBody.innerHTML = ''; // 기존 테이블 초기화

	// 선택된 3차 카테고리를 테이블에 반영
	detailCategories.forEach(function(detailCategory) {
		var row = document.createElement('tr');
		row.classList.add('text-center');

		var mainCategoryCell = document.createElement('th');
		mainCategoryCell.scope = 'row';
		mainCategoryCell.innerText = document.getElementById('mainCategorySelect').options[document.getElementById('mainCategorySelect').selectedIndex].text;

		var subCategoryCell = document.createElement('td');
		subCategoryCell.innerText = document.getElementById('subCategorySelect').options[document.getElementById('subCategorySelect').selectedIndex].text;

		var detailCategoryCell = document.createElement('td');
		detailCategoryCell.innerText = detailCategory.detailCategoryName;

		row.appendChild(mainCategoryCell);
		row.appendChild(subCategoryCell);
		row.appendChild(detailCategoryCell);

		categoryTableBody.appendChild(row);
	});
}

// 서브 카테고리 및 세부 카테고리를 테이블에 추가하는 함수
function displaySubCategoriesWithDetails(detailCategories, subCategory) {
	var categoryTableBody = document.getElementById('categoryTableBody');
	categoryTableBody.innerHTML = ''; // 기존 테이블 초기화

	var mainCategoryText = document.getElementById('mainCategorySelect').options[document.getElementById('mainCategorySelect').selectedIndex].text;

	detailCategories.forEach(function(detailCategory) {
		var row = document.createElement('tr');
		row.classList.add('text-center');

		var mainCategoryCell = document.createElement('th');
		mainCategoryCell.scope = 'row';
		mainCategoryCell.innerText = mainCategoryText;

		var subCategoryCell = document.createElement('td');
		subCategoryCell.innerText = subCategory.subCategoryName;

		var detailCategoryCell = document.createElement('td');
		detailCategoryCell.innerText = detailCategory.detailCategoryName;

		row.appendChild(mainCategoryCell);
		row.appendChild(subCategoryCell);
		row.appendChild(detailCategoryCell);

		categoryTableBody.appendChild(row);
	});
}


// 기존 수정 함수에서 prompt 호출
function editMainCategory() {
	var selectedCategoryId = document.getElementById('mainCategorySelect').value;
	var newCategoryName = prompt('새로운 1차 카테고리 이름을 입력하세요:');

	if (newCategoryName === null || newCategoryName.trim() === '') {
		console.log('카테고리 수정이 취소되었거나 이름이 유효하지 않습니다.');
		return null;
	}

	if (selectedCategoryId === '') {
		alert('수정할 메인 카테고리를 선택하세요.');
		return null;
	}

	var xhr = new XMLHttpRequest();
	xhr.open("PUT", "/mainCategories/" + selectedCategoryId, true);
	xhr.setRequestHeader("Content-Type", "application/json");

	var data = {
		mainCategoryName: newCategoryName
	};

	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4) {
			if (xhr.status === 200) {
				alert("메인 카테고리가 정상적으로 수정되었습니다.");

				// 수정된 내용을 반영하기 위해 메인 카테고리 목록을 다시 로드
				loadMainCategories();

				// 1차 카테고리 수정 후에 해당하는 2차 카테고리를 다시 로드
				loadSubCategories(selectedCategoryId);

				// 다시 선택하여 테이블에 표시
				document.getElementById('mainCategorySelect').value = selectedCategoryId;
				displayMainCategory(); // 테이블에 반영

			} else {
				console.error("오류: " + xhr.status + " - " + xhr.responseText);
			}
		}
	};

	xhr.send(JSON.stringify(data));
	return newCategoryName; // 수정된 카테고리 이름 반환
}

// 서브 카테고리 이름 수정 함수
function editSubCategory(selectedCategoryId) {
	var newCategoryName = prompt('새로운 서브 카테고리 이름을 입력하세요:');

	if (!selectedCategoryId) {
		alert('수정할 서브 카테고리를 선택하세요.');
		return null;
	}

	if (!newCategoryName || newCategoryName.trim() === '') {
		console.log('카테고리 이름이 유효하지 않습니다.');
		alert('새로운 카테고리 이름을 입력하세요.');
		return null;
	}

	var xhr = new XMLHttpRequest();
	xhr.open("PUT", "/subCategories/" + selectedCategoryId, true);
	xhr.setRequestHeader("Content-Type", "application/json");

	var data = {
		subCategoryName: newCategoryName
	};

	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4) {
			if (xhr.status === 200) {
				alert("서브 카테고리가 정상적으로 수정되었습니다.");

				// 수정된 서브 카테고리를 드롭다운과 테이블에 반영
				updateCategoryDisplay('subCategorySelect', selectedCategoryId, newCategoryName);

				// 현재 선택 상태 유지
				document.getElementById('subCategorySelect').value = selectedCategoryId;

				// 세부 카테고리 선택 항목 유지
				const previouslySelectedDetailCategoryId = document.getElementById('detailCategorySelect').value;

				// 3차 카테고리를 다시 로드하고 나서 콜백으로 테이블 갱신
				loadDetailCategoriesWithCallback(selectedCategoryId, function(detailCategories) {
					// 수정된 서브 카테고리를 기반으로 테이블 업데이트
					displaySubCategoriesWithDetails(detailCategories, {
						subCategoryId: selectedCategoryId,
						subCategoryName: newCategoryName
					});

					// 세부 카테고리의 선택 상태 복구 (수정 후에도 선택된 상태를 유지)
					if (previouslySelectedDetailCategoryId) {
						document.getElementById('detailCategorySelect').value = previouslySelectedDetailCategoryId;
					}
				});

			} else {
				console.error("오류: " + xhr.status + " - " + xhr.responseText);
			}
		}
	};

	xhr.send(JSON.stringify(data));
	return newCategoryName; // 수정된 카테고리 이름 반환
}

// 세부 카테고리 이름 수정 함수
function editDetailCategory(selectedCategoryId) {
	console.log("Selected Detail Category ID:", selectedCategoryId);
	console.log("editDetailCategory function called with ID:", selectedCategoryId);
	var newCategoryName = prompt('새로운 세부 카테고리 이름을 입력하세요:');

	if (selectedCategoryId === '' || isNaN(selectedCategoryId)) {
		alert('수정할 세부 카테고리를 선택하세요.');
		return;
	}

	if (newCategoryName.trim() === '') {
		alert('새로운 카테고리 이름을 입력하세요.');
		return;
	}

	var xhr = new XMLHttpRequest();
	console.log("Attempting to update detail category with ID:", selectedCategoryId, " and new name:", newCategoryName);
	xhr.open("PUT", "/detailCategories/" + selectedCategoryId, true);
	console.log("Sending request to /detailCategories/" + selectedCategoryId);

	xhr.setRequestHeader("Content-Type", "application/json");

	var data = {
		detailCategoryId: selectedCategoryId,
		detailCategoryName: newCategoryName
	};

	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4) {
			if (xhr.status === 200) {
				alert("세부 카테고리가 정상적으로 수정되었습니다.");

				// 수정된 세부 카테고리를 드롭다운과 테이블에 반영
				updateCategoryDisplay('detailCategorySelect', selectedCategoryId, newCategoryName);

				// 현재 선택 상태 유지
				document.getElementById('detailCategorySelect').value = selectedCategoryId;

				// 수정된 세부 카테고리를 테이블에 반영
				displayDetailCategories([{
					detailCategoryId: selectedCategoryId,
					detailCategoryName: newCategoryName
				}]);

			} else {
				console.error("오류: " + xhr.status + " - " + xhr.responseText);
			}
		}
	};

	xhr.send(JSON.stringify(data));
}

// 메인 카테고리 삭제 함수
function deleteMainCategory(mainCategoryId) {
    if (!confirm('정말로 이 1차 카테고리를 삭제하시겠습니까?')) {
        return; // 사용자 확인을 통해 삭제 취소
    }

    var xhr = new XMLHttpRequest();
    xhr.open("DELETE", "/mainCategories/" + mainCategoryId, true);
    xhr.setRequestHeader("Content-Type", "application/json");

    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            if (xhr.status >= 200 && xhr.status < 300) {
                alert("메인 카테고리가 정상적으로 삭제되었습니다.");
                window.location.reload();
				
            } else {
                console.error("오류: " + xhr.status + " - " + xhr.responseText);
                alert("메인 카테고리 삭제 중 오류가 발생했습니다. 관리자에게 문의하세요.");
            }
        }
    };

    xhr.send();
}

// 서브 카테고리 삭제 함수
function deleteSubCategory(subCategoryId) {
    if (!confirm('정말로 이 2차 카테고리를 삭제하시겠습니까?')) {
        return; // 사용자 확인을 통해 삭제 취소
    }

    var xhr = new XMLHttpRequest();
    xhr.open("DELETE", "/subCategories/" + subCategoryId, true);
    xhr.setRequestHeader("Content-Type", "application/json");

    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
             if (xhr.status >= 200 && xhr.status < 300) {
                alert("서브 카테고리가 정상적으로 삭제되었습니다.");

                window.location.reload();

                document.getElementById("detailCategorySelect").innerHTML = '<option value="">3차 카테고리 선택</option>';
            } else {
                console.error("오류: " + xhr.status + " - " + xhr.responseText);
                alert("서브 카테고리 삭제 중 오류가 발생했습니다. 관리자에게 문의하세요.");
            }
        }
    };

    xhr.send();
}

// 세부 카테고리 삭제 함수
function deleteDetailCategory(detailCategoryId) {
    if (!confirm('정말로 이 3차 카테고리를 삭제하시겠습니까?')) {
        return; // 사용자 확인을 통해 삭제 취소
    }

    var xhr = new XMLHttpRequest();
    xhr.open("DELETE", "/detailCategories/" + detailCategoryId, true);
    xhr.setRequestHeader("Content-Type", "application/json");

    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                alert("세부 카테고리가 정상적으로 삭제되었습니다.");

                window.location.reload();
            } else {
                console.error("오류: " + xhr.status + " - " + xhr.responseText);
                alert("세부 카테고리 삭제 중 오류가 발생했습니다. 관리자에게 문의하세요.");
            }
        }
    };

    xhr.send();
}

// 메인 카테고리 추가 함수
function addMainCategory(categoryName) {
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "/mainCategories", true);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                alert("카테고리 추가에 성공했습니다");
               window.location.reload();
            } else {
                alert("카테고리 추가에 실패했습니다");
            }
        }
    };
    xhr.send(JSON.stringify({ mainCategoryName: categoryName }));
}

// 서브 카테고리 추가 함수
function addSubCategory(mainCategoryId, subCategoryName) {
    const data = {
        subCategoryName: subCategoryName,
        foreignMainCategoryId: parseInt(mainCategoryId),
    };

    var xhr = new XMLHttpRequest();
    xhr.open("POST", "/subCategories", true);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            if (xhr.status === 201) {
                alert("서브 카테고리가 성공적으로 추가되었습니다.");
                window.location.reload();
            } else {
                alert("서브 카테고리 추가에 실패했습니다");
            }
        }
    };
    xhr.send(JSON.stringify(data));
}

// 세부 카테고리 추가 함수
function addDetailCategory(mainCategoryId, subCategoryId, detailCategoryName) {
    const data = {
        detailCategoryName: detailCategoryName,
        foreignSubCategoryId: parseInt(subCategoryId),
        foreignMainCategoryId: parseInt(mainCategoryId),
    };

    var xhr = new XMLHttpRequest();
    xhr.open("POST", "/detailCategories", true);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            if (xhr.status === 201 || (xhr.status === 200 && xhr.responseText === "1")) {
                alert("세부 카테고리가 성공적으로 추가되었습니다.");
                window.location.reload();
            } else {
                alert("세부 카테고리 추가에 실패했습니다");
            }
        }
    };
    xhr.send(JSON.stringify(data));
}

// 페이지 로드 시 메인 카테고리 로드
window.onload = function() {
	loadMainCategories();
	// 이벤트 리스너도 window.onload 안에 추가하여 모든 요소가 로드된 후 동작하도록 설정합니다.
	document.getElementById("mainCategorySelect").addEventListener("change", mainCategoryChange);
	document.getElementById("subCategorySelect").addEventListener("change", subCategoryChange);
	document.getElementById("detailCategorySelect").addEventListener("change", detailCategoryChange);
};
