<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script>
    
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

// 메인 카테고리 변경 시 서브 카테고리 로드
function mainCategoryChange() {
    loadSubCategories();
}

// 서브 카테고리 변경 시 세부 카테고리 로드
function subCategoryChange() {
    loadDetailCategories();
}

// 세부 카테고리 변경 시 테이블 업데이트
function detailCategoryChange() {
    var detailCategoryId = document.getElementById('detailCategorySelect').value;
    if (detailCategoryId) {
        var selectedOption = document.querySelector('#detailCategorySelect option:checked');
        var detailCategoryName = selectedOption ? selectedOption.text : '';

        var categoryTableBody = document.getElementById('categoryTableBody');
        categoryTableBody.innerHTML = ''; // 기존 테이블 초기화

        var row = document.createElement('tr');
        row.classList.add('text-center');

        var mainCategoryCell = document.createElement('th');
        mainCategoryCell.scope = 'row';
        mainCategoryCell.innerText = document.getElementById('mainCategorySelect').options[document.getElementById('mainCategorySelect').selectedIndex].text;
        mainCategoryCell.onclick = function() { editMainCategory(); };

        var subCategoryCell = document.createElement('td');
        subCategoryCell.innerText = document.getElementById('subCategorySelect').options[document.getElementById('subCategorySelect').selectedIndex].text;
        subCategoryCell.onclick = function() {
    var selectedCategoryId = subCategory.subCategoryId;
    console.log("Sub category cell clicked. ID:", selectedCategoryId);
    editSubCategory(selectedCategoryId);
};

        var detailCategoryCell = document.createElement('td');
        detailCategoryCell.innerText = detailCategoryName;
        detailCategoryCell.onclick = function() {
    var selectedCategoryId = detailCategoryId;
    console.log("Detail category cell clicked. ID:", selectedCategoryId);
    editDetailCategory(detailCategoryId);
};

        var actionCell = document.createElement('td');
        actionCell.classList.add('text-center');
        actionCell.innerHTML = `
            <a href="#" class="btn btn-light-danger" onclick="openDeleteWindow(${detailCategoryId})">삭제</a>
        `;

        row.appendChild(mainCategoryCell);
        row.appendChild(subCategoryCell);
        row.appendChild(detailCategoryCell);
        row.appendChild(actionCell);

        categoryTableBody.appendChild(row);
    }
}

// 선택된 메인 카테고리에 따른 서브 카테고리 로드 함수
function loadSubCategories() {
    var mainCategoryId = document.getElementById('mainCategorySelect').value;

    if (!mainCategoryId) {
        document.getElementById('subCategorySelect').innerHTML = '<option value="">메인 카테고리를 선택해주세요</option>';
        return;
    }

    var xhr = new XMLHttpRequest();
    xhr.open("GET", "/mainSubCategories?mainCategoryId=" + mainCategoryId, true);
    xhr.setRequestHeader("Content-Type", "application/json");

    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                var subCategories = JSON.parse(xhr.responseText);
                var subCategorySelect = document.getElementById('subCategorySelect');
                subCategorySelect.innerHTML = '<option value="">2차카테고리 선택</option>'; // 이전 옵션 초기화

                subCategories.forEach(function(subCategory) {
                    var option = document.createElement('option');
                    option.value = subCategory.subCategoryId;
                    option.text = subCategory.subCategoryName;
                    subCategorySelect.appendChild(option);
                });

                // 서브 카테고리 로드 후 세부 카테고리 셀렉트 초기화
                document.getElementById('detailCategorySelect').innerHTML = '<option value="">서브 카테고리를 선택해주세요</option>';

                // 서브 카테고리 데이터를 테이블에 추가
                displaySubCategories(subCategories);
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
                var detailCategories = JSON.parse(xhr.responseText);
                var detailCategorySelect = document.getElementById('detailCategorySelect');
                detailCategorySelect.innerHTML = '<option value="">3차카테고리 선택</option>'; // 이전 옵션 초기화

                detailCategories.forEach(function(detailCategory) {
                    var option = document.createElement('option');
                    option.value = detailCategory.detailCategoryId;
                    option.text = detailCategory.detailCategoryName;
                    detailCategorySelect.appendChild(option);
                });

                // 세부 카테고리 데이터를 테이블에 추가
                displayDetailCategories(detailCategories);
            } else {
                console.error("세부 카테고리 불러오기 중 오류:", xhr.status, xhr.responseText);
                alert("세부 카테고리 불러오기 오류. 관리자에게 문의하세요.");
            }
        }
    };

    xhr.send();
}

// 서브 카테고리 데이터를 테이블에 추가
function displaySubCategories(subCategories) {
    var categoryTableBody = document.getElementById('categoryTableBody');
    categoryTableBody.innerHTML = ''; // 기존 테이블 초기화

    subCategories.forEach(function(subCategory) {
        var row = document.createElement('tr');
        row.classList.add('text-center');

        var mainCategoryCell = document.createElement('th');
        mainCategoryCell.scope = 'row';
        mainCategoryCell.innerText = document.getElementById('mainCategorySelect').options[document.getElementById('mainCategorySelect').selectedIndex].text;
        mainCategoryCell.onclick = function() { editMainCategory(); };

        var subCategoryCell = document.createElement('td');
        subCategoryCell.innerText = subCategory.subCategoryName;
        subCategoryCell.onclick = function() {
    var selectedCategoryId = subCategory.subCategoryId;
    console.log("Sub category cell clicked. ID:", selectedCategoryId);
    editSubCategory(selectedCategoryId);
};

        var detailCategoryCell = document.createElement('td');
        detailCategoryCell.innerText = ''; // 세부 카테고리 빈 값

        var actionCell = document.createElement('td');
        actionCell.classList.add('text-center');
        actionCell.innerHTML = `
            <a href="#" class="btn btn-light-danger" onclick="openDeleteWindow(${subCategory.subCategoryId})">삭제</a>
        `;

        row.appendChild(mainCategoryCell);
        row.appendChild(subCategoryCell);
        row.appendChild(detailCategoryCell);
        row.appendChild(actionCell);

        categoryTableBody.appendChild(row);
    });
}

// 세부 카테고리 데이터를 테이블에 추가
function displayDetailCategories(detailCategories) {
    var categoryTableBody = document.getElementById('categoryTableBody');
    categoryTableBody.innerHTML = ''; // 기존 테이블 초기화

    detailCategories.forEach(function(detailCategory) {
        var row = document.createElement('tr');
        row.classList.add('text-center');

        var mainCategoryCell = document.createElement('th');
        mainCategoryCell.scope = 'row';
        mainCategoryCell.innerText = document.getElementById('mainCategorySelect').options[document.getElementById('mainCategorySelect').selectedIndex].text;
        mainCategoryCell.onclick = function() { editMainCategory(); };

        var subCategoryCell = document.createElement('td');
        subCategoryCell.innerText = document.getElementById('subCategorySelect').options[document.getElementById('subCategorySelect').selectedIndex].text;
        subCategoryCell.onclick = function() { editSubCategory(); };

        var detailCategoryCell = document.createElement('td');
        detailCategoryCell.innerText = detailCategory.detailCategoryName;
        detailCategoryCell.onclick = function() {
    var selectedCategoryId = detailCategory.detailCategoryId;
    if (!selectedCategoryId) {
        console.error("Invalid Detail Category ID");
        return;
    }
    console.log("Detail category cell clicked. ID:", selectedCategoryId);
    editDetailCategory(parseInt(selectedCategoryId));
};

        var actionCell = document.createElement('td');
        actionCell.classList.add('text-center');
        actionCell.innerHTML = `
            <a href="#" class="btn btn-light-danger" onclick="openDeleteWindow(${detailCategory.detailCategoryId})">삭제</a>
        `;

        row.appendChild(mainCategoryCell);
        row.appendChild(subCategoryCell);
        row.appendChild(detailCategoryCell);
        row.appendChild(actionCell);

        categoryTableBody.appendChild(row);
    });
}

// 메인 카테고리 이름 수정 함수
function editMainCategory() {
    var selectedCategoryId = document.getElementById('mainCategorySelect').value;
    var newCategoryName = prompt('새로운 1차 카테고리 이름을 입력하세요:');
    if (newCategoryName === null) {
    return;
}
    if (newCategoryName === null) {
        console.log('$1 카테고리 수정이 취소되었습니다.');
        return;
    }
    if (newCategoryName === null) {
        console.log('$1 카테고리 수정이 취소되었습니다.');
        return;
    }

    if (selectedCategoryId === '') {
        alert('수정할 메인 카테고리를 선택하세요.');
        return;
    }

    if (!newCategoryName || newCategoryName.trim() === '') {
        console.log('$1 카테고리 이름이 유효하지 않습니다.');
        alert('새로운 카테고리 이름을 입력하세요.');
        return;
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
                document.querySelectorAll('#categoryTableBody th').forEach(function(cell) {
                    if (cell.innerText === document.getElementById('mainCategorySelect').options[document.getElementById('mainCategorySelect').selectedIndex].text) {
                        cell.innerText = newCategoryName;
                    }
                }); // 변경 사항 반영을 위해 테이블만 업데이트
            } else {
                console.error("오류: " + xhr.status + " - " + xhr.responseText);
            }
        }
    };

    xhr.send(JSON.stringify(data));
}

// 서브 카테고리 이름 수정 함수
function editSubCategory(selectedCategoryId) {
    // var selectedCategoryId = document.getElementById('subCategorySelect').value;
    var newCategoryName = prompt('새로운 서브 카테고리 이름을 입력하세요:');

    if (!selectedCategoryId) {
        alert('수정할 서브 카테고리를 선택하세요.');
        return;
    }

    if (!newCategoryName || newCategoryName.trim() === '') {
        console.log('카테고리 이름이 유효하지 않습니다.');
        alert('새로운 카테고리 이름을 입력하세요.');
        return;
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
                loadSubCategories(); // 서브 카테고리 수정 후 변경 사항 반영
            } else {
                console.error("오류: " + xhr.status + " - " + xhr.responseText);
            }
        }
    };

    xhr.send(JSON.stringify(data));
}

// 세부 카테고리 이름 수정 함수
function editDetailCategory(selectedCategoryId) {
    // // var selectedCategoryId = document.getElementById('detailCategorySelect').value;
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
    if (isNaN(selectedCategoryId)) {
    return;
}
    xhr.setRequestHeader("Content-Type", "application/json");

    var data = {
        detailCategoryId: selectedCategoryId,
        detailCategoryName: newCategoryName
    };

    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                alert("세부 카테고리가 정상적으로 수정되었습니다.");
                loadDetailCategories(); // 변경 사항 반영을 위해 테이블만 새로고침
            } else {
                console.error("오류: " + xhr.status + " - " + xhr.responseText);
            }
        }
    };

    xhr.send(JSON.stringify(data));
}

// 삭제 버튼 클릭 시 새 창 열기
function openDeleteWindow(categoryId) {
    window.open(`/deleteCategory?categoryId=${categoryId}`, '_blank', 'width=600,height=400');
}

// 페이지 로드 시 메인 카테고리 로드
window.onload = function() {
    loadMainCategories();
};
</script>
