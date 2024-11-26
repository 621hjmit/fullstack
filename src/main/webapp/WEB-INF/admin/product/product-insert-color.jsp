<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>색상 선택</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body>
    <div class="container mt-4">
        <!-- [ Page Header ] -->
        <div class="page-header">
            <h2 class="text-center">색상 선택</h2>
        </div>
        <!-- [ Main Content ] -->
        <div class="row justify-content-center mt-4">
            <div class="col-sm-8">
                <div class="card table-card">
                    <div class="card-body">
                        <form id="colorOptions">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th class="text-center">색상 선택</th>
                                    </tr>
                                </thead>
                                <tbody id="colorTableBody">
                                    <!-- 색상 체크박스가 여기에 동적으로 추가됩니다. -->
                                </tbody>
                            </table>
                        </form>
                        <div class="text-center mt-4">
                            <button type="button" class="btn btn-primary" onclick="submitColors()">확인</button>
                            <button type="button" class="btn btn-secondary" onclick="window.close()">취소</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // 페이지가 로드될 때 색상 데이터를 가져옴
        window.onload = function() {
            loadColors();
        };

        // 색상 목록을 가져오는 함수
        function loadColors() {
            axios.get('/productColors')
                .then(response => {
                    const colors = response.data; // 색상 목록 (JSON 데이터)
                    const colorTableBody = document.getElementById('colorTableBody');
                    
                    // 색상 데이터를 사용하여 체크박스를 동적으로 생성
                    colors.forEach(color => {
                        const tr = document.createElement('tr');
                        const td = document.createElement('td');
                        
                        // 체크박스와 레이블을 생성하여 td에 추가
                        const div = document.createElement('div');
                        div.className = 'form-check';
                        
                        const checkbox = document.createElement('input');
                        checkbox.type = 'checkbox';
                        checkbox.className = 'form-check-input';
                        checkbox.value = color.pcId; // 색상 ID를 값으로 설정
                        checkbox.dataset.colorName = color.pcName; // 색상 이름 저장
                        checkbox.id = `color${color.pcId}`;
                        
                        const label = document.createElement('label');
                        label.className = 'form-check-label';
                        label.htmlFor = `color${color.pcId}`;
                        label.textContent = color.pcName;

                        // div에 체크박스와 레이블 추가
                        div.appendChild(checkbox);
                        div.appendChild(label);

                        // td에 div 추가
                        td.appendChild(div);
                        tr.appendChild(td);
                        colorTableBody.appendChild(tr);
                    });
                })
                .catch(error => {
                    console.error('색상 데이터를 불러오는 중 오류 발생:', error);
                    alert('색상 데이터를 불러오는 중 오류가 발생했습니다. 관리자에게 묻어주세요.');
                });
        }

        // 부모 창에 선택된 색상 결과를 반영하는 함수
        function submitColors() {
            const selectedColors = [];
            const checkboxes = document.querySelectorAll("#colorOptions input[type='checkbox']:checked");
            checkboxes.forEach(checkbox => {
                selectedColors.push({
                    id: checkbox.value, // 색상 ID
                    name: checkbox.dataset.colorName // 색상 이름
                });
            });

            // 부모 창의 updateColors 함수 호출
            if (window.opener && !window.opener.closed) {
                window.opener.updateColors(selectedColors);
                window.close(); // 선택 후 창 닫기
            }
        }
    </script>

    <!-- Bootstrap JS and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>