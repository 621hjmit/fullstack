<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사이즈 선택</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body>
    <div class="container mt-4">
        <!-- [ Page Header ] -->
        <div class="page-header">
            <h2 class="text-center">사이즈 선택</h2>
        </div>
        <!-- [ Main Content ] -->
        <div class="row justify-content-center mt-4">
            <div class="col-sm-8">
                <div class="card table-card">
                    <div class="card-body">
                        <form id="sizeOptions">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th class="text-center">사이즈 선택</th>
                                    </tr>
                                </thead>
                                <tbody id="sizeTableBody">
                                    <!-- 사이즈 체크박스가 여기에 동적으로 추가됩니다. -->
                                </tbody>
                            </table>
                        </form>
                        <div class="text-center mt-4">
                            <button type="button" class="btn btn-primary" onclick="submitSizes()">확인</button>
                            <button type="button" class="btn btn-secondary" onclick="window.close()">취소</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // 페이지가 로드될 때 사이즈 데이터를 가져오고, 선택된 상태를 설정
        window.onload = function() {
            loadSizes();
        };

     // 사이즈 목록을 가져오는 함수
        function loadSizes() {
            // 부모 창에서 전달된 선택된 사이즈 목록 가져오기
            const urlParams = new URLSearchParams(window.location.search);
            const selectedSizes = JSON.parse(decodeURIComponent(urlParams.get('selectedSizes'))) || [];

            axios.get('/productSizes')
                .then(response => {
                    const sizes = response.data; // 사이즈 목록 (JSON 데이터)
                    const sizeTableBody = document.getElementById('sizeTableBody');

                    // 사이즈 데이터를 사용하여 체크박스를 동적으로 생성
                    sizes.forEach(size => {
                        const tr = document.createElement('tr');
                        const td = document.createElement('td');

                        // 체크박스와 레이블을 생성하여 td에 추가
                        const div = document.createElement('div');
                        div.className = 'form-check';

                        const checkbox = document.createElement('input');
                        checkbox.type = 'checkbox';
                        checkbox.className = 'form-check-input';
                        checkbox.value = size.psName;
                        checkbox.dataset.sizeId = size.psId;  // 사이즈 ID 추가
                        checkbox.id = `size${size.psId}`;

                        // 전달된 선택된 사이즈에 따라 체크박스 상태 설정
                        if (selectedSizes.some(selectedSize => selectedSize.id === size.psId)) {
                            checkbox.checked = true;
                        }

                        const label = document.createElement('label');
                        label.className = 'form-check-label';
                        label.htmlFor = `size${size.psId}`;
                        label.textContent = size.psName;

                        // div에 체크박스와 레이블 추가
                        div.appendChild(checkbox);
                        div.appendChild(label);

                        // td에 div 추가
                        td.appendChild(div);
                        tr.appendChild(td);
                        sizeTableBody.appendChild(tr);
                    });
                })
                .catch(error => {
                    console.error('사이즈 데이터를 불러오는 중 오류 발생:', error);
                    alert('사이즈 데이터를 불러오는 중 오류가 발생했습니다. 관리자에게 문의하세요.');
                });
        }

     // 부모 창에 선택된 사이즈 결과를 반영하는 함수
        function submitSizes() {
            const selectedSizes = [];
            const checkboxes = document.querySelectorAll("#sizeOptions input[type='checkbox']:checked");
            checkboxes.forEach(checkbox => {
                selectedSizes.push({
                    id: parseInt(checkbox.dataset.sizeId),  // 사이즈 ID
                    name: checkbox.value  // 사이즈 이름
                });
            });

            // 부모 창의 updateSizes 함수 호출
            if (window.opener && !window.opener.closed) {
                window.opener.updateSizes(selectedSizes);
                window.close(); // 선택 후 창 닫기
            }
        }
    </script>

    <!-- Bootstrap JS and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

    <!-- Bootstrap JS and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>