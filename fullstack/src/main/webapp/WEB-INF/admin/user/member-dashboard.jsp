<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/admin/common/header.jsp" %>
<link rel="stylesheet" href="/static/css/admin/user/dashboard.css" >

<!-- [ Main Content ] start -->
<div class="pc-container">
  
  <div class="pc-content">
    <!-- [ page title ] start -->
    <div class="page-header">
      <div class="page-block">
        <div class="row align-items-center">
          <div class="col-md-12">
            <div class="page-header-title">
              <h2 class="mb-0">고객 대쉬보드</h2>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- [ page title ] end -->
    
    <div class="row">
      
      <!-- [ block1 : 회원 현황 ] start -->
      <div class="col-sm-12">
        <div class="card table-card">
          <div class="card-body p-4 ">
            <h4 class="mb-0 p-2 ">회원 현황</h4>
            <table class="table  table-bordered">
					  <thead class="text-center">
					    <tr>
					      <th scope="col">신규회원
					        <button type="button" class="btn btn-icon btn-light-info" data-bs-toggle="popover" 
					        data-bs-title="신규회원"  data-bs-placement="bottom"
					        data-bs-content="오늘 기준으로 가입한 회원 수입니다.">
					        <i class="ti ti-info-circle"></i></button>
					      </th>
					      <th scope="col">방문회원
                    <button type="button" class="btn btn-icon btn-light-info" data-bs-toggle="popover" 
                    data-bs-title="방문회원"  data-bs-placement="bottom"
                    data-bs-content="오늘 기준으로 쇼핑몰에 로그인한 회원 수입니다.">
                    <i class="ti ti-info-circle"></i></button>
                  </th>
					      <th scope="col">휴면회원
                    <button type="button" class="btn btn-icon btn-light-info" data-bs-toggle="popover" 
                    data-bs-title="휴면회원"  data-bs-placement="bottom"
                    data-bs-content="전체 휴면 회원수 입니다.">
                    <i class="ti ti-info-circle"></i></button>
					      </th>
					      <th scope="col">탈퇴회원
                    <button type="button" class="btn btn-icon btn-light-info" data-bs-toggle="popover" 
                    data-bs-title="탈퇴회원"  data-bs-placement="bottom"
                    data-bs-content="최근 일주일 동안 탈퇴한 회원 수 입니다.">
                    <i class="ti ti-info-circle"></i></button>
					      </th>
					      <th scope="col">TOTAL
                    <button type="button" class="btn btn-icon btn-light-info" data-bs-toggle="popover" 
                    data-bs-title="TOTAL" data-bs-html="true" data-bs-placement="bottom"
                    data-bs-content="쇼핑몰의 총 회원 수 입니다.<br/>휴면회원은 쇼핑몰 총 회원수에서 제외됩니다.">
                    <i class="ti ti-info-circle"></i></button>
                  </th>
					    </tr>
					  </thead>
					  <tbody class="text-end">
					    <tr>
					      <td><strong class="text-decoration-underline fs-4" id="new">0</strong> 명</td>
					      <td><strong class="text-decoration-underline fs-4" id="visit">0</strong> 명</td>
					      <td><strong class="text-decoration-underline fs-4" id="dormant">0</strong> 명</td>
					      <td><strong class="text-decoration-underline fs-4" id="cancel">0</strong> 명</td>
					      <td><strong class="text-decoration-underline fs-4" id="total">0</strong> 명</td>
					    </tr>
					  </tbody>
					</table>
          </div>
        </div>
      </div>
      <!-- [ block1 : 회원 현황 ] end -->
      
      <!-- [ block2 : 최근 가입 회원 ] start -->
      <div class="col-sm-12">
        <div class="card table-card">
          <div class="card-body p-4 ">
            <div class="d-flex flex-row  align-items-end">
              <h4 class="mb-0 p-2 ">최근 가입 회원
                 <button type="button" class="btn btn-icon btn-light-info" data-bs-toggle="popover" 
                 data-bs-title="최근 가입 회원"  data-bs-placement="bottom" data-bs-html="true"
                 data-bs-content="
                 <ul>
                  <li>최근 가입일시 순으로 회원 3명까지 표기됩니다.</li>
                   <li>회원의 가입일시, 아이디, 이름, 메모, 등급/관계 정보를 확인할 수 있습니다.</li>
                   <li>메모는 해당 회원에 대해 메모가 작성되었을 경우 메모 내용을 확인할 수 있습니다.</li>
                 </ul>">
                 <i class="ti ti-info-circle"></i></button>
              </h4>
            </div>
            <table class="table  table-bordered">
              <thead class="text-center">
                <tr>
                  <th scope="col">가입일시</th>
                  <th scope="col">아이디</th>
                  <th scope="col">이름</th>
                  <th scope="col">메모</th>
                </tr>
              </thead>
              <tbody class="text-center" id="setNewUser">
                <tr>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
      <!-- [ block3 : done ] end -->
      <!-- [ Modal ] start -->
			<div class="fade fade modal-animate anim-fade-in-scale modal" id="userMemo" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h1 class="modal-title fs-5" id="userMemoLabel">메모</h1>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			        <p id="userMemoContent"></p>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			      </div>
			    </div>
			  </div>
			</div>
			<!-- [ Modal ] end -->
    </div>
  </div>
</div>
<!-- [ Main Content ] end -->

<!-- [ Modal ] end -->
<!-- [Page Specific JS] start -->

<!-- [Page Specific JS] end -->
<script>
window.onload = init;
function init(){
	document.title = "고객 대쉬보드 | Hermes Admin";
	getMemberStatus();
	getNewMember();
	modal();
}
function modal(){
	const exampleModal = document.getElementById('userMemo')
	if (exampleModal) {

	  exampleModal.addEventListener('show.bs.modal', event => {
		  console.log(exampleModal.querySelector('.modal-title'));
	    // Button that triggered the modal
	    const button = event.relatedTarget
	    // Extract info from data-bs-* attributes
	    // If necessary, you could initiate an Ajax request here
	    // and then do the updating in a callback.

	    // Update the modal's content.
	    const recipient = button.getAttribute('data-bs-whatever')
	    const memo = button.getAttribute('data-memo')
	    const modalTitle = exampleModal.querySelector('.modal-title')
	    const modalBodyInput = exampleModal.querySelector('.modal-body input')
      const userMemoContent = document.getElementById('userMemoContent');
	    modalTitle.textContent = recipient+ ' 메모';
	    userMemoContent.innerText = memo;
	  })
	}
}
function getMemberStatus(){
  axios.get('/stats') // API URL을 실제 엔드포인트로 변경
  .then(response => {
    const statisticsList = response.data; // List<StatisticsVO> 데이터를 받아옴
    // 각 통계 항목을 개별적으로 출력 (선택사항)
    statisticsList.forEach(stat => {
      document.getElementById(stat.description).innerHTML = stat.count; 
    });
  })
  .catch(error => {
    console.error('Error fetching statistics:', error);
  });
}
function getNewMember(){
	axios.get('/new') // Replace with your actual API URL
  .then(response => {
    const users = response.data; // Assuming this is an array of user objects
    const setNewUser = document.getElementById('setNewUser'); // Select the tbody element

    // Clear existing rows if needed
    setNewUser.innerHTML = '';

    // Loop through the users and create table rows
    for (let i = 0; i < users.length; i++) {
      const user = users[i];

      // Create a new row
      const row = document.createElement('tr');

      // Create table cells with user information
      const cell1 = document.createElement('td');
      cell1.textContent = user.credat; // Replace 'name' with the appropriate property
      row.appendChild(cell1);

      const cell2 = document.createElement('td');
      cell2.textContent = user.uiEmail; // Replace 'email' with the appropriate property
      row.appendChild(cell2);

      const cell3 = document.createElement('td');
      const userName = user.uiLastName + user.uiFirstName;
      cell3.textContent = userName; // Replace 'age' with the appropriate property
      row.appendChild(cell3);
      
      const memo =user.umMemo; 
      if(memo!=null){
		    const cell4 = document.createElement('td');
	      cell4.innerHTML  = '<button type="button" class="btn btn-icon btn-link-warning avtar-xs" data-bs-toggle="modal" data-bs-target="#userMemo" data-bs-whatever="'+ userName +'" data-memo="'+memo+'"><i class="ph-duotone ph-notepad"></i></button>';
	      row.appendChild(cell4);
      }

      // Append the row to the tbody
      setNewUser.appendChild(row);
    }
  })
  .catch(error => {
    console.error('Error fetching users:', error);
  });
}
</script>
<%@ include file="/WEB-INF/admin/common/footer.jsp" %>