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

function setCount(Obj){
	itemsPerPage = Obj.value;
	getMemberInfo(page);
}
function chk(str){
	return (str=='' || str==null);
}
function getGender(gender){
	return gender=='1'?'남자':'여자';
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
function type(number){
  if(number==0){
	  return "특별회원";
  }else if(number==1){
	  return "일반회원";
	}else if(number==2){
		return "불량회원";
  }
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
function printData(response){
  const gradeList = document.querySelector('#searchGrade'); // 테이블의 tbody 요소
  if (gradeList) {  // 요소가 존재하는지 확인
    gradeList.innerHTML = '<option value="0">전체 등급</option>';
  } else {
    console.error('searchGrade 요소를 찾을 수 없습니다.');
  }
  const list = response; // List<StatisticsVO> 데이터를 받아옴
  list.forEach(item => {
    const row = document.createElement('option');
    row.value = item.giNum;
    row.innerHTML = item.giName;
    gradeList.appendChild(row);
  })
}

function setTotalResults(totalItems){
	const resultElements = document.querySelectorAll(".totalResults");
  resultElements.forEach(element => {
      element.textContent = `${totalItems}`;
  });
}

function getMemberInfo(pageNum,Obj){
page = pageNum;
  axios.post('/dormant-users',{
	  params: {
       count: itemsPerPage,
       page: page
    }
	}) // API URL을 실제 엔드포인트로 변경
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
      '<td>' + user.dormdat + '</td>' +
      '<td>' + user.uiLastName+user.uiFirstName + '</td>' +
      '<td>' + setTypeIcon(user.uiType) +' '+ user.uiEmail +'</td>' +
      '<td>' + user.uiPhone + '</td>' +
      '<td>' + getGender(user.uiGender) + '</td>' ;
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
function search(page){
	const searchType = document.querySelector('#searchType').value;
	const searchText = document.querySelector('#searchText').value;
	let 	start					= document.querySelector('input[name="range-start"]').value;
	let 	end						= document.querySelector('input[name="range-end"]').value;
	const period				= document.querySelector('#input[name=period]:checked'); // 0이면 null처리 해줘야하는 셀렉박스
	const periodValue		= period ? period.value : null;

	if(periodValue==999){
		start = null;
		end = null;
	}
	
  let uiLastName, uiFirstName, uiEmail, uiPhone;
  if(searchType==1){
    uiLastName = document.querySelector('#searchText').value;
		uiLastName = uiLastName==''?null:uiLastName;
  }else if(searchType==2){
    uiFirstName = document.querySelector('#searchText').value;
		uiFirstName = uiFirstName==''?null:uiFirstName;
  }else if(searchType==3){
    uiEmail = document.querySelector('#searchText').value;
		uiEmail = uiEmail==''?null:uiEmail;
  }else if(searchType==4){
    uiPhone = document.querySelector('#searchText').value;
		uiPhone = uiPhone==''?null:uiPhone;
  }

	const param = {
    uiLastName : 	uiLastName		,
    uiFirstName : uiFirstName		,
    uiEmail :			uiEmail				, 
    uiPhone:			uiPhone				,
		uiStartDate:	start					,
		uiEndDate:		end						,
    count: 				itemsPerPage	,
    page: 				page
  };
	console.table(param);
	axios.post('/dormant-users', param, {
	  headers: {
	    'Content-Type': 'application/json'
	  }
	})
	.then(response => {
    getListData(response);
	})
	.catch(error => {
	  console.error('There was an error!', error);
	  alert('There was an error processing your request.');
	});
}