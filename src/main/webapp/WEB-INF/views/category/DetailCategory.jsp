<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>세부 카테고리 관리</title>
</head>
<body>
	<h2>세부 카테고리 관리</h2>

	<label for="mainCategorySelect">메인 카테고리 선택:</label>
	<select id="mainCategorySelect" onchange="loadSubCategories()">
		<option value="">메인 카테고리 선택</option>
	</select>
	<br>

	<label for="subCategorySelect">서브 카테고리 선택:</label>
	<select id="subCategorySelect" onchange="loadDetailCategories()">
		<option value="">메인 카테고리를 선택해주세요</option>
	</select>
	<br>

	<label for="detailCategorySelect">세부 카테고리 선택:</label>
	<select id="detailCategorySelect">
		<option value="">세부 카테고리를 선택해주세요</option>
	</select>
	<br>

	<button onclick="updateDetailCategory()">세부 카테고리 수정</button>
	<br>
	<button onclick="deleteDetailCategory()">세부 카테고리 삭제</button>

	<br>
	<br>

	<label for="detailCategoryInput">새로운 세부 카테고리 추가:</label>
	<input type="text" id="detailCategoryInput" placeholder="세부 카테고리 이름 입력">
	<button onclick="addDetailCategory()">세부 카테고리 추가</button>

	<script>
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
			xhr.open("GET", "/mainSubCategories?mainCategoryId="
					+ mainCategoryId, true);
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

		// 선택된 서브 카테고리에 따른 세부 카테고리 로드 함수
		function loadSubCategories() {
			var mainCategoryId = document.getElementById('mainCategorySelect').value;

			if (!mainCategoryId) {
				document.getElementById('subCategorySelect').innerHTML = '<option value="">메인 카테고리를 선택해주세요</option>';
				document.getElementById('detailCategorySelect').innerHTML = '<option value="">세부 카테고리를 선택해주세요</option>'; // 초기화
				return;
			}

			var xhr = new XMLHttpRequest();
			xhr.open("GET", "/mainSubCategories?mainCategoryId="
					+ mainCategoryId, true);
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

						// 서브 카테고리 선택 후 세부 카테고리 자동 로드
						loadDetailCategories(); // 자동으로 세부 카테고리 로드
					} else {
						console.error("서브 카테고리 불러오기 중 오류:", xhr.status,
								xhr.responseText);
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
			xhr.open("GET", "/subDetailCategories?subCategoryId="
					+ subCategoryId, true);
			xhr.setRequestHeader("Content-Type", "application/json");

			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4) {
					if (xhr.status === 200) {
						var detailCategories = JSON.parse(xhr.responseText);
						var detailCategorySelect = document
								.getElementById('detailCategorySelect');
						detailCategorySelect.innerHTML = ''; // 이전 옵션 초기화

						detailCategories.forEach(function(detailCategory) {
							var option = document.createElement('option');
							option.value = detailCategory.detailCategoryId;
							option.text = detailCategory.detailCategoryName;
							detailCategorySelect.appendChild(option);
						});
					} else {
						console.error("세부 카테고리 불러오기 중 오류:", xhr.status,
								xhr.responseText);
						alert("세부 카테고리 불러오기 오류. 관리자에게 문의하세요.");
					}
				}
			};

			xhr.send();
		}

		//세부카테고리 수정 함수
		function updateDetailCategory() {
			var detailCategoryId = document
					.getElementById('detailCategorySelect').value; // 수정된 부분

			if (!detailCategoryId) { // 수정된 부분
				alert("수정할 세부 카테고리를 선택해주세요");
				return;
			}

			var newDetailCategoryName = prompt("수정할 세부 카테고리 이름을 입력해주세요:");

			if (!newDetailCategoryName) {
				alert("세부 카테고리 이름을 입력해주세요.");
				return;
			}

			var xhr = new XMLHttpRequest();
			xhr.open("PUT", '/detailCategories/' + detailCategoryId, true); // 수정된 부분
			xhr.setRequestHeader("Content-Type", "application/json");

			var data = {
				detailCategoryId : detailCategoryId,
				detailCategoryName : newDetailCategoryName
			};

			console.log("전송할 데이터:", JSON.stringify(data)); // 디버깅 로그 추가

			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4) {
					if (xhr.status === 200) {
						alert("세부 카테고리가 성공적으로 수정되었습니다.");
						loadDetailCategories(); // 세부 카테고리 목록 새로고침
					} else {
						console.error("세부 카테고리 수정 중 오류 발생:", xhr.status,
								xhr.responseText);
						alert("세부 카테고리 수정 오류. 관리자에게 문의하세요.");
					}
				}
			};
			xhr.send(JSON.stringify(data));
		}

		// 세부 카테고리 추가 함수
		function addDetailCategory() {
			var detailCategoryName = document.getElementById('detailCategoryInput').value;
			var subCategoryId = document.getElementById('subCategorySelect').value;
			var mainCategoryId = document.getElementById('mainCategorySelect').value;

			if (!subCategoryId) {
				alert("서브 카테고리를 선택해주세요.");
				return;
			}
			if (!detailCategoryName) {
				alert("추가할 세부 카테고리 이름을 입력해주세요.");
				return;
			}

			// POST 요청으로 세부 카테고리 추가
			const data = {
				detailCategoryName : detailCategoryName,
				foreignSubCategoryId : parseInt(subCategoryId),
				foreignMainCategoryId : parseInt(mainCategoryId)
			};

			var addXhr = new XMLHttpRequest();
			addXhr.open("POST", "/detailCategories", true);
			addXhr.setRequestHeader("Content-Type", "application/json");

			addXhr.onreadystatechange = function() {
				if (addXhr.readyState === 4) {
					console.log("응답 내용:", addXhr.responseText); // 응답 내용을 로그로 출력
					if (addXhr.status === 201
							|| (addXhr.status === 200 && addXhr.responseText === "1")) {
						alert("세부 카테고리가 성공적으로 추가되었습니다.");
						document.getElementById('detailCategoryInput').value = ''; // 입력 필드 초기화
						loadDetailCategories(); // 세부 카테고리 목록 새로고침
					} else {
						console.error("세부 카테고리 추가 중 오류 발생:", addXhr.status,
								addXhr.responseText);
					}
				}
			};

			addXhr.send(JSON.stringify(data)); // JSON 데이터 전송
		}

		// 세부 카테고리 삭제 함수
		function deleteDetailCategory() {
			var detailCategoryId = document
					.getElementById('detailCategorySelect').value;

			if (!detailCategoryId) {
				alert("삭제할 세부 카테고리를 선택해주세요.");
				return;
			}

			if (!confirm("정말 이 세부 카테고리를 삭제하시겠습니까?")) {
				return;
			}

			var xhr = new XMLHttpRequest();
			xhr.open("DELETE", "/detailCategories/" + detailCategoryId, true);
			xhr.setRequestHeader("Content-Type", "application/json");

			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4) {
					if (xhr.status === 200 || xhr.status === 204) { // 200과 204 둘 다 성공 처리
						alert("세부 카테고리가 성공적으로 삭제되었습니다.");
						loadSubCategories(); // 서브 카테고리 목록 새로고침
					} else {
						console.error("세부 카테고리 삭제 중 오류 발생:", xhr.status,
								xhr.responseText);
						alert("세부 카테고리 삭제 오류. 관리자에게 문의하세요.");
					}
				}
			};

			xhr.send();
		}
	</script>
</body>
</html>
