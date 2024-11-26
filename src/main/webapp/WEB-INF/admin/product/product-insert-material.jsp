<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>소재 선택</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body>
    <div class="container mt-4">
        <!-- [ Page Header ] -->
        <div class="page-header">
            <h2 class="text-center">소재 선택</h2>
        </div>
        <!-- [ Main Content ] -->
        <div class="row justify-content-center mt-4">
            <div class="col-sm-8">
                <div class="card table-card">
                    <div class="card-body">
                        <form id="materialOptions">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th class="text-center">소재 선택</th>
                                    </tr>
                                </thead>
                                <tbody id="materialTableBody">
                                    <!-- 소재 라디오 버튼이 여기에 동적으로 추가됩니다. -->
                                </tbody>
                            </table>
                        </form>
                        <div class="text-center mt-4">
                            <button type="button" class="btn btn-primary" onclick="submitMaterial()">확인</button>
                            <button type="button" class="btn btn-secondary" onclick="window.close()">취소</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
    // 페이지가 로드될 때 소재 데이터를 가져옴
    window.onload = function() {
        loadMaterials();
    };

    // 소재 목록을 가져오는 함수
    function loadMaterials() {
        axios.get('/productMaterials')
            .then(response => {
                const materials = response.data; // 소재 목록 (JSON 데이터)
                const materialTableBody = document.getElementById('materialTableBody');
                
                // 소재 데이터를 사용하여 라디오 버튼을 동적으로 생성
                materials.forEach(material => {
                    const tr = document.createElement('tr');
                    const td = document.createElement('td');
                    
                    // 라디오 버튼과 레이블을 생성하여 td에 추가
                    const div = document.createElement('div');
                    div.className = 'form-check';
                    
                    const radio = document.createElement('input');
                    radio.type = 'radio';
                    radio.className = 'form-check-input';
                    radio.name = 'material'; // 같은 이름으로 설정하여 한 번에 하나만 선택 가능하게 함
                    radio.value = material.pmName;
                    radio.id = `material${material.pmId}`;
                    radio.setAttribute('data-id', material.pmId); // materialId를 data-id로 설정
                    
                    const label = document.createElement('label');
                    label.className = 'form-check-label';
                    label.htmlFor = `material${material.pmId}`;
                    label.textContent = material.pmName;

                    // div에 라디오 버튼과 레이블 추가
                    div.appendChild(radio);
                    div.appendChild(label);

                    // td에 div 추가
                    td.appendChild(div);
                    tr.appendChild(td);
                    materialTableBody.appendChild(tr);
                });
            })
            .catch(error => {
                console.error('소재 데이터를 불러오는 중 오류 발생:', error);
                alert('소재 데이터를 불러오는 중 오류가 발생했습니다. 관리자에게 문의하세요.');
            });
    }

    // 부모 창에 선택된 소재 결과를 반영하는 함수
    function submitMaterial() {
        const selectedMaterial = document.querySelector("#materialOptions input[type='radio']:checked");
        
        if (selectedMaterial) {
            // 부모 창의 updateMaterials 함수 호출
            if (window.opener && !window.opener.closed) {
                const materialId = selectedMaterial.getAttribute('data-id'); // data-id 속성으로 materialId 가져오기
                const materialName = selectedMaterial.value;
                window.opener.updateMaterials(materialId, materialName);
                window.close(); // 선택 후 창 닫기
            }
        } else {
            alert('소재를 선택해주세요.');
        }
    }
</script>

    <!-- Bootstrap JS and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>