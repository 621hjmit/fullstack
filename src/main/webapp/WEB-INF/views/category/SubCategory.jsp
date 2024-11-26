<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html>
<head>
<title>서브 카테고리 관리</title>
</head>
<body>
	<h2>서브 카테고리 관리</h2>

	<label for="mainCategorySelect">메인 카테고리 선택:</label>
	<select id="mainCategorySelect" onchange="loadSubCategories()">
		<option value="">메인 카테고리 선택</option>
	</select>

	<label for="subCategorySelect">서브 카테고리 선택:</label>
	<select id="subCategorySelect">
		<option value="">메인 카테고리를 선택해주세요</option>
	</select><br>
	<button onclick="updateSubCategory()">서브 카테고리 수정</button><br>
	<button onclick="deleteSubCategory()">서브 카테고리 삭제</button>

	<br>
	<br>

	<label for="subCategoryInput">새로운 서브 카테고리 추가:</label>
	<input type="text" id="subCategoryInput" placeholder="서브 카테고리 이름 입력">
	<button onclick="addSubCategory()">서브 카테고리 추가</button>

	<script>
	// 페이지가 로드될 때 메인 카테고리를 가져오는 함수
	window.onload = function() {
		loadMainCategories();
	};

	// 메인 카테고리 로드 함수
	function loadMainCategories() {
		var xhr = new XMLHttpRequest();
		xhr.open("GET", "/mainCategories", true);
		xhr.setRequestHeader("Content-Type", "application/json");

		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4) {
				if (xhr.status === 200) {
					var categories = JSON.parse(xhr.responseText);
					var mainCategorySelect = document
							.getElementById('mainCategorySelect');
					categories.forEach(function(category) {
						var option = document.createElement('option');
						option.value = category.mainCategoryId;
						option.text = category.mainCategoryName;
						mainCategorySelect.appendChild(option);
					});
				} else {
					console.error("메인 카테고리 불러오기 중 오류:", xhr.status,
							xhr.responseText);
					alert("메인 카테고리 불러오기 오류. 관리자에게 문의하세요.");
				}
			}
		};

		xhr.send();
	}

	// 선택된 메인 카테고리에 따른 서브 카테고리 로드 함수
	function loadSubCategories() {
		var mainCategoryId = document.getElementById('mainCategorySelect').value;

		if (!mainCategoryId) {
			document.getElementById('subCategorySelect').innerHTML = '<option value="">메인 카테고리를 선택해주세요</option>';
			return;
		}

		var xhr = new XMLHttpRequest();
		xhr.open("GET", "/mainSubCategories?mainCategoryId=" + mainCategoryId,
				true);
		xhr.setRequestHeader("Content-Type", "application/json");

		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4) {
				if (xhr.status === 200) {
					var subCategories = JSON.parse(xhr.responseText);
					var subCategorySelect = document
							.getElementById('subCategorySelect');
					subCategorySelect.innerHTML = ''; // 이전 옵션 초기화

					subCategories.forEach(function(subCategory) {
						var option = document.createElement('option');
						option.value = subCategory.subCategoryId;
						option.text = subCategory.subCategoryName;
						subCategorySelect.appendChild(option);
					});
				} else {
					console.error("서브 카테고리 불러오기 중 오류:", xhr.status,
							xhr.responseText);
					alert("서브 카테고리 불러오기 오류. 관리자에게 문의하세요.");
				}
			}
		};

		xhr.send();
	}

	// 서브 카테고리 수정 함수
	function updateSubCategory() {
		var subCategoryId = document.getElementById('subCategorySelect').value;

		if (!subCategoryId) {
			alert("수정할 서브 카테고리를 선택해주세요.");
			return;
		}

		var newSubCategoryName = prompt("새로운 서브 카테고리 이름을 입력해주세요:");

		if (!newSubCategoryName) {
			alert("서브 카테고리 이름을 입력해주세요.");
			return;
		}

		var xhr = new XMLHttpRequest();
		xhr.open("PUT", "/subCategories/" + subCategoryId, true);
		xhr.setRequestHeader("Content-Type", "application/json");

		var data = {
			subCategoryId : subCategoryId,
			subCategoryName : newSubCategoryName
		};

		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4) {
				if (xhr.status === 200) {
					alert("서브 카테고리가 성공적으로 수정되었습니다.");
					loadSubCategories(); // 서브 카테고리 목록 새로고침
				} else {
					console.error("서브 카테고리 수정 중 오류 발생:", xhr.status,
							xhr.responseText);
					alert("서브 카테고리 수정 오류. 관리자에게 문의하세요.");
				}
			}
		};

		xhr.send(JSON.stringify(data));
	}

	// 서브 카테고리 삭제 함수
	function deleteSubCategory() {
	    var subCategoryId = document.getElementById('subCategorySelect').value;

	    if (!subCategoryId) {
	        alert("삭제할 서브 카테고리를 선택해주세요.");
	        return;
	    }

	    if (!confirm("정말 이 서브 카테고리를 삭제하시겠습니까?")) {
	        return;
	    }

	    var xhr = new XMLHttpRequest();
	    xhr.open("DELETE", "/subCategories/" + subCategoryId, true); // 수정된 부분
	    xhr.setRequestHeader("Content-Type", "application/json");

	    xhr.onreadystatechange = function() {
	        if (xhr.readyState === 4) {
	            if (xhr.status === 204) { // 204 No Content 응답
	                alert("서브 카테고리가 성공적으로 삭제되었습니다.");
	                loadSubCategories(); // 서브 카테고리 목록 새로고침
	            } else {
	                console.error("서브 카테고리 삭제 중 오류 발생:", xhr.status,
	                        xhr.responseText);
	                alert("서브 카테고리 삭제 오류. 관리자에게 문의하세요.");
	            }
	        }
	    };

	    xhr.send();
	}

	// 서브 카테고리 추가 함수
	function addSubCategory() {
	    var subCategoryName = document.getElementById('subCategoryInput').value;
	    var mainCategoryId = document.getElementById('mainCategorySelect').value;
	    if (!mainCategoryId) {
	        alert("메인 카테고리를 선택해주세요.");
	        return;
	    }

	    if (!subCategoryName) {
	        alert("추가할 서브 카테고리 이름을 입력해주세요.");
	        return;
	    }

        const data = {
                subCategoryName: subCategoryName,
                foreignMainCategoryId: parseInt(mainCategoryId) // 정수로 변환
            };

            var addXhr = new XMLHttpRequest();
            addXhr.open("POST", "/subCategories", true);
            addXhr.setRequestHeader("Content-Type", "application/json");

            addXhr.onreadystatechange = function() {
                if (addXhr.readyState === 4) {
                    if (addXhr.status === 201) {
                        alert("서브 카테고리가 성공적으로 추가되었습니다.");
                        document.getElementById('subCategoryInput').value = ''; // 입력 필드 초기화
                        loadSubCategories(); // 서브 카테고리 목록 새로고침
                    } else {
                        console.error("서브 카테고리 추가 중 오류 발생:", addXhr.status,
                            addXhr.responseText);
                    }
                }
            };
            addXhr.send(JSON.stringify(data)); // JSON 데이터 전송
	}
</script>

</body>
</html>