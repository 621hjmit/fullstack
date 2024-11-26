<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Main Category Management</title>
</head>
<body>
	<h2>메인 카테고리 설정</h2>

	<!-- 메인 카테고리 조회 -->
	<select id="mainCategorySelect">
		<option value="">메인카테고리 항목 선택</option>
		<br>
	</select>

	<!-- 메인 카테고리 수정, 삭제 버튼 -->
	<br>
	<button id="editMainCategoryBtn">수정</button>
	<br>
	<button id="deleteMainCategoryBtn">삭제</button>
	<br>

	<!-- 메인 카테고리 추가 -->
	<h3>새로운 메인 카테고리의 이름을 입력하세요</h3>
	<input type="text" id="newMainCategoryName" placeholder="메인카테고리 이름 입력">
	<button id="addMainCategoryBtn">추가</button>

	<script>
		// 페이지 로드 시 메인 카테고리 조회
		document.addEventListener('DOMContentLoaded', function() {
			loadMainCategories();
		});

		// 메인 카테고리 조회 함수
		function loadMainCategories() {
			var xhr = new XMLHttpRequest();
			xhr.open('GET', '/mainCategories', true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					try {
						var data = JSON.parse(xhr.responseText);
						var select = document
								.getElementById('mainCategorySelect');
						select.innerHTML = '<option value="">메인카테고리 항목 선택</option>'; // 초기화

						// 카테고리 목록을 셀렉트 박스에 추가
						data.forEach(function(category) {
							var option = document.createElement('option');
							option.value = category.mainCategoryId;
							option.textContent = category.mainCategoryName;
							select.appendChild(option);
						});
					} catch (e) {
						console.error('JSON 파싱 오류:', e);
					}
				}
			};
			xhr.send();
		}

		// 메인 카테고리 추가
		document.getElementById('addMainCategoryBtn').onclick = function() {
			var newCategoryName = document
					.getElementById('newMainCategoryName').value.trim();
			if (newCategoryName === '') {
				alert('Please enter a category name.');
				return;
			}

			var xhr = new XMLHttpRequest();
			xhr.open('POST', '/mainCategories', true);
			xhr.setRequestHeader('Content-Type', 'application/json');
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4) {
					if (xhr.status === 200) {
						alert('카테고리 추가에 성공했습니다');
						
						document.getElementById('newMainCategoryName').value = ''; // 입력 필드 초기화
						loadMainCategories(); // 카테고리 목록 다시 불러오기
					} else {
						alert('카테고리 추가에 실패했습니다');
					}
				}
			};
			xhr.send(JSON.stringify({
				mainCategoryName : newCategoryName
			}));
		};

		// 메인 카테고리 수정
		  document.getElementById('editMainCategoryBtn').onclick = function() {
            var selectedCategoryId = document.getElementById('mainCategorySelect').value;
            var newCategoryName = prompt('새로운 카테고리 이름을 입력하세요:');

            if (selectedCategoryId === '') {
                alert('수정할 카테고리를 선택하세요.');
                return;
            }

            if (newCategoryName.trim() === '') {
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
                        location.reload(); // 페이지 새로고침하여 변경 사항 반영
                    } else {
                        console.error("오류: " + xhr.status + " - " + xhr.responseText);
                    }
                }
            };

            xhr.send(JSON.stringify(data));
        };

		// 메인 카테고리 삭제
		document.getElementById('deleteMainCategoryBtn').onclick = function() {
			var selectedCategoryId = document
					.getElementById('mainCategorySelect').value;

			if (selectedCategoryId === '') {
				alert('Please select a category to delete.');
				return;
			}

			if (!confirm('정말 삭제하시겠습니까?')) {
				return;
			}

			var xhr = new XMLHttpRequest();
			xhr.open('DELETE', '/mainCategories/' + selectedCategoryId, true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4) {
					if (xhr.status === 200) {
						alert('메인 카테고리 삭제를 성공했습니다');
						loadMainCategories(); // 카테고리 목록 다시 불러오기
					} else {
						alert('메인 카테고리 삭제를 실패했습니다');
					}
				}
			};
			xhr.send();
		};
	</script>
</body>
</html>