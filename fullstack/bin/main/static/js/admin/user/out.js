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
  getList(page);
  period();
	getGrades();
  getOutInfos();
}
function setPage(){
  let str = document.querySelector(".page-header-title>h2").textContent;
  document.title = str + " | Hermes Admin";
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

function printData(response, elementID,str){
  const gradeList = document.querySelector(elementID); // 테이블의 tbody 요소
  if (gradeList) {  // 요소가 존재하는지 확인
    gradeList.innerHTML = '<option value="0">'+str+'</option>';
  } else {
    console.error('#'+elementID+' 요소를 찾을 수 없습니다.');
  }
  const list = response; // List<StatisticsVO> 데이터를 받아옴
  list.forEach(item => {
    const row = document.createElement('option');
    row.value = item.giNum;
    row.innerHTML = item.giName;
    gradeList.appendChild(row);
  })
}
function printOutData(response, elementID,str){
  const gradeList = document.querySelector(elementID); // 테이블의 tbody 요소
  if (gradeList) {  // 요소가 존재하는지 확인
    gradeList.innerHTML = '<option value="0">'+str+'</option>';
  } else {
    console.error('#'+elementID+' 요소를 찾을 수 없습니다.');
  }
  const list = response; // List<StatisticsVO> 데이터를 받아옴
  list.forEach(item => {
    const row = document.createElement('option');
    row.value = item.otNum;
    row.innerHTML = item.otDesc;
    gradeList.appendChild(row);
  })
}


function setTypeIcon(number){
  let html = '';
  if(number==0){
    html = '<button class="btn btn-icon btn-link-warning avtar-xs"><i class="ph-duotone ph-star"></i></button>';
    return html;
  }else if(number==1){
    return html;
  }else if(number==2){
    html = '<button class="btn btn-icon btn-link-danger avtar-xs"><i class="ph-duotone ph-warning-circle"></i></button>';
    return html;
  }
}
function getGender(gender){
  return gender=='1'?'남자':'여자';
}
function setTotalResults(totalItems){
	const resultElements = document.querySelectorAll(".totalResults");
  resultElements.forEach(element => {
      element.textContent = `${totalItems}`;
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
      '<td>' + user.credat + '</td>' +
      '<td>' + user.outdat + '</td>' +
      '<td>' + user.uiLastName+user.uiFirstName + '</td>' +
      '<td>' + setTypeIcon(user.uiType) + user.uiEmail +'</td>' +
      '<td>' + user.giName + '</td>' +
      '<td>' + getGender(user.uiGender) + '</td>' +
      /*
      '<td>' +
        '<button class="btn btn-icon btn-link-success avtar-xs" data-phone="'+ user.uiPhone +'"><i class="ph-duotone ph-envelope"></i></button>' +
        '<button class="btn btn-icon btn-link-success avtar-xs"><i class="ph-duotone ph-messenger-logo"></i></button>' +
        '<button class="btn btn-icon btn-link-warning avtar-xs"><i class="ph-duotone ph-notepad"></i></button>' +
      '</td>' +
      */
      '<td>' +
        '<button type="button" class="btn btn-outline-primary btn-sm" data-uinum="'+user.uiNum+'" onclick="goOrderPage('+user.uiNum+')">주문</button>' +
      '</td>';
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
    html += '<a class="page-link" onclick="getList(' + (startNum - 1) + ')" tabindex="-1">Previous</a>';
    html += '</li>';
  }

  // 페이지 번호 표시
  for (var i = startNum; i <= lastNum; i++) {

    if (i === page) {
      html += '<li class="page-item active"><button class="page-link" onclick="getList(' + i + ',$(this))">' + i + '</button></li>';  // 현재 페이지는 active 클래스 추가
    } else {
      html += '<li class="page-item"><button class="page-link" onclick="getList(' + i + ',$(this))">' + i + '</button></li>';
    }
  }

  // 다음 페이지 버튼 (lastNum이 totalNum과 다르면 활성화)
  if (lastNum < totalNum) {
    html += '<li class="page-item">';
    html += '<a class="page-link" onclick="getList(' + (lastNum + 1) + ')">Next</a>';
    html += '</li>';
  }

  html += '</ul>';

  document.querySelector('#pagination').innerHTML = html;  
  setPaginationActive();
  
}
//검색 버튼 누르건, 새로고침 누르거나, 페이지네이션 열면 일루온다.
function getList(pageNum,Obj){
  
  page = pageNum;
	
	let 	searchGrade		= document.querySelector('#searchGrade').value; // 0이면 null처리 해줘야하는 셀렉박스
	const searchEmail 	= document.querySelector('#searchEmail').value;
	let		searchOutType = document.querySelector('#searchOutType').value; //uiOut 0이면 null로
	let 	searchOutDesc = document.querySelector('#searchOutDesc').value; // 0이면 null처리 해줘야하는 셀렉박스
  let 	start					= document.querySelector('input[name="range-start"]').value;
  let 	end						= document.querySelector('input[name="range-end"]').value;
	const period				= document.querySelector('#input[name=period]:checked'); // 0이면 null처리 해줘야하는 셀렉박스
	const periodValue		= period ? period.value : null;
	
	if(periodValue==999){
		start = null;
		end = null;
	}

	searchGrade 	= searchGrade == 0 ? null : searchGrade; // 0이면 null처리 해줘야하는 셀렉박스
	searchOutType 	= searchOutType == 0 ? null : searchOutType; // 0이면 null처리 해줘야하는 셀렉박스
	searchOutDesc = searchOutDesc == 0 ? null : searchOutDesc; // 0이면 null처리 해줘야하는 셀렉박스
	//인자값이 없으면 true임 그러면 countSearch가 0으로 세팅됨.
	
  const param = {
    count:			itemsPerPage	,
    page:				page					,
	  giNum:			searchGrade		,
    uiStartDate:start					,
    uiEndDate:	end						,
	  uiEmail:		searchEmail		,
		uiOut:			searchOutType	,
		otNum:			searchOutDesc
  };
	console.log("uiOut:"+searchOutType);	
  axios.post('/out-user',param) // API URL을 실제 엔드포인트로 변경
  .then(response => {
    getListData(response);
  })
  .catch(error => {
    console.error('Error fetching statistics:', error);
  });
}

function getGrades(){
  axios.get('/grades')
  .then(response => {
    printData(response.data,'#searchGrade','전체 등급');
  })
  .catch(error => {
    console.error('Error fetching statistics:', error);
  });
}

function getOutInfos(){
  axios.get('/out-infos')
  .then(response => {
    printOutData(response.data,'#searchOutDesc','전체');
  })
  .catch(error => {
    console.error('Error fetching statistics:', error);
  });
}


function goOrderPage(uiNum){
  location.href ="/admin/order/order-management?uiNum="+uiNum;
}