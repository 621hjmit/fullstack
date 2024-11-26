/**
 * 
 */
document.addEventListener('DOMContentLoaded', function () {
  init();
});
let data;
let currentPage = 1;
let page=1;
let itemsPerPage=10;
let totalItems;
function init(){
  setPage();
  getMemberInfo(page);
	period();
}
function setPage(){
	let str = document.querySelector(".page-header-title>h2").textContent;
  document.title = str + " | Hermes Admin";
	document.querySelector("#pageTitle").textContent = str;
  
  if (typeof $.fn.datepicker !== 'undefined') {
    console.log("Bootstrap Datepicker is loaded!");
  } else {
    console.log("Bootstrap Datepicker is not loaded.");
  }
  $('#datepicker_range').datepicker({
    buttonClass: 'btn',
    orientation: 'bottom left',
    format: "yyyymmdd"
  });
}

function setPaginationActive(){
  const paginationNumber = page - 1;
  $('.page-nums.active').removeClass('active');
  $('.page-nums').eq(paginationNumber).addClass('active');
}
function setCount(Obj){
	itemsPerPage = Obj.value;
	getMemberInfo(page);
}
function period(){
	$( "input[name=period]" ).on( "click", function() {
	  const period = $(this).val();
	  let today = new Date();
	      today.setDate(today.getDate());
	      today = today.getFullYear().toString() +
	              (today.getMonth() + 1).toString().padStart(2, '0') +
	              today.getDate().toString().padStart(2, '0');
	          
	  let start = new Date();
	      start.setDate(start.getDate() - period);
	      start = start.getFullYear().toString() +
	                (start.getMonth() + 1).toString().padStart(2, '0') +
	                start.getDate().toString().padStart(2, '0');
									
		if(period!=999){
	  	settingDatepicker(start, today);
		}else{
	  	settingDatepicker(null, null);
		}
	});
}
function settingDatepicker(start,end){
  $('input[name="range-start"]').val(start);
  $('input[name="range-end"]').val(end);
}
function chk(str){
	return (str=='' || str==null);
}
function check_all(className, checkbox) {
    // 전체 선택 체크박스를 클릭했을 때, 모든 개별 체크박스를 해당 상태로 설정
    var checkboxes = document.querySelectorAll('.' + className);
    checkboxes.forEach(function (checkboxItem) {
        checkboxItem.checked = checkbox.checked;
    });
}
// 개별 체크박스를 클릭할 때
function check(checkbox) {
    // 전체 선택 체크박스 상태를 업데이트
    var allCheckbox = document.querySelector('.allChk');
    var checkboxes = document.querySelectorAll('.check');
    // 모든 개별 체크박스가 체크되었는지 확인
    var allChecked = true;
    checkboxes.forEach(function (checkboxItem) {
        if (!checkboxItem.checked) {
            allChecked = false;
        }
    });
    // 전체 선택 체크박스의 상태를 업데이트
    if (allChecked) {
        allCheckbox.checked = true;
    } else {
        // 개별 체크박스가 하나라도 체크되지 않으면 전체 선택 체크박스를 해제
        allCheckbox.checked = false;
    }
}

function setTotalResults(totalItems){
	const resultElements = document.querySelectorAll(".totalResults");
  resultElements.forEach(element => {
    element.textContent = `${totalItems}`;
  });
}

function getMemberInfo(pageNum,Obj){
  
  page = pageNum;
  
  //페이지 처음 열때랑...  검색할때 다 이 함수를 쓴다.
	const searchType  = document.querySelector('#searchType').value;
	const searchText  = document.querySelector('#searchText').value;
	let 	status      = document.querySelector('input[name="newsStatus"]:checked');
	const unStartDate =  document.querySelector('input[name="range-start"]').value;
	const unEndDate   =  document.querySelector('input[name="range-end"]').value;

	if(status !=null ){
		status = status.value;
		if(status == 'all'){
			status = null;
		}
	}
	
  let unLastName, unFirstName, unEmail, uiPhone;
  if(searchType==1){
    unLastName = document.querySelector('#searchText').value;
		unLastName = unLastName==''?null:unLastName;
  }else if(searchType==2){
    unFirstName = document.querySelector('#searchText').value;
		unFirstName = unFirstName==''?null:unFirstName;
  }else if(searchType==3){
    unEmail = document.querySelector('#searchText').value;
		unEmail = unEmail==''?null:unEmail;
  }else if(searchType==4){
    uiPhone = document.querySelector('#searchText').value;
    uiPhone = uiPhone==''?null:uiPhone;
  }
  
	const data = {
    unLastName : unLastName,
    unFirstName : unFirstName,
    unEmail :unEmail, 
    uiPhone :uiPhone, 
    unStatus :status,
		unStartDate : unStartDate,
		unEndDate : unEndDate,
    count: itemsPerPage,
    page: page
  };
	
  axios.post('/newsletter',data)
  .then(response => {
    getListData(response);
  })
  .catch(error => {
    console.error('Error fetching statistics:', error);
  });
}
function getListData(response){
  const userList = document.querySelector('#userList'); // 테이블의 tbody 요소
  userList.innerHTML ='';
  const users = response.data.list; // List<StatisticsVO> 데이터를 받아옴
  totalItems = response.data.count; // List<StatisticsVO> 데이터를 받아옴
	setTotalResults(totalItems);
  users.forEach(user => {
    const row = document.createElement('tr');
    row.innerHTML = 
      '<td><input type="checkbox" onclick="check(this)" class="check" value="'+user.unNum+'" name="unNum"></td>' +
      '<td>' + user.unSubscriptionDate + '</td>' +
      '<td>' + user.unLastName+user.unFirstName + '</td>' +
      '<td>' + user.unEmail + '</td>' +
      '<td>' + user.uiPhone + '</td>' +
      '<td>' + user.unStatus + '</td>' +
      '<td>' + user.unUnsubscribeDate + '</td>';
      /*
      +
      '<td>' +
        '<button class="btn btn-icon btn-link-success avtar-xs"><i class="ph-duotone ph-envelope"></i></button>' +
        '<button class="btn btn-icon btn-link-success avtar-xs" data-email="'+user.unEmail+'"><i class="ph-duotone ph-messenger-logo"></i></button>' +
        '<button class="btn btn-icon btn-link-warning avtar-xs"><i class="ph-duotone ph-notepad"></i></button>' +
      '</td>'
      */
      
    userList.appendChild(row);
  })
	if(users.length<1){
		$(".no-result").removeClass("visually-hidden");
		$("#dataTable").addClass("visually-hidden");
	}else{
		$(".no-result").addClass("visually-hidden");
		$("#dataTable").removeClass("visually-hidden");
	}
  // pagination 표시
  var html = '';
  html += '<ul class="pagination justify-content-center">';
  
  //var lastNum = startNum + 9;
  var startNum = ((Math.ceil(page/10))-1)*10+1;
  var totalNum = Math.ceil(totalItems/itemsPerPage);
  var lastNum = Math.min(startNum + 9, totalNum);
  // 이전 페이지 버튼 (startNum이 1이 아니면 활성화)
  if (startNum > 1) {
    html += '<li class="page-item">';
    html += '<a class="page-link" onclick="getMemberInfo(' + (startNum - 1) + ')" tabindex="-1">Previous</a>';
    html += '</li>';
  }

  // 페이지 번호 표시
  for (var i = startNum; i <= lastNum; i++) {

    if (i === page) {
      html += '<li class="page-item active"><button class="page-link" onclick="getMemberInfo(' + i + ',$(this))">' + i + '</button></li>';  // 현재 페이지는 active 클래스 추가
    } else {
      html += '<li class="page-item"><button class="page-link" onclick="getMemberInfo(' + i + ',$(this))">' + i + '</button></li>';
    }
  }

  // 다음 페이지 버튼 (lastNum이 totalNum과 다르면 활성화)
  if (lastNum < totalNum) {
    html += '<li class="page-item">';
    html += '<a class="page-link" onclick="getMemberInfo(' + (lastNum + 1) + ')">Next</a>';
    html += '</li>';
  }

  html += '</ul>';

  document.querySelector('#pagination').innerHTML = html;  
  setPaginationActive();
  
}
function setSub(satusOfNews){
	const checkedObjs = document.querySelectorAll('input[name=unNum]');
  const param = [];
  // 선택된 체크박스들의 정보를 param 배열에 담기
  checkedObjs.forEach(checkedObj => {
    if (checkedObj.checked) {
      param.push({
        unNum: checkedObj.value
      });
    }
  });
  // Axios로 PUT 요청 보내기
  
  const url = satusOfNews ? '/add-newsletter' : '/delete-newsletter';
  const message = satusOfNews ? '구독중으로' : '구독해지로';
  axios.put(url, param, {
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(response => {
    alert(response.data+'명의 회원의 구독상태를 '+message+' 변경하였습니다.');
    getMemberInfo(page);
    console.log("page:"+page);
  })
  .catch(error => {
    console.error('There was an error!', error);
    alert('There was an error processing your request.');
  });
}
