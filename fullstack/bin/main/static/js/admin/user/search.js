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
let countSearch = 0;
function init(){
  setPage();
  getMemberInfo(page);
  getGrades();
}
function setPage(){
	let str = document.querySelector(".page-header-title>h2").textContent;
  document.title = str + " | Hermes Admin";
  if (typeof $.fn.datepicker !== 'undefined') {
    //console.log("Bootstrap Datepicker is loaded!");
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
function goOrderPage(uiNum){
  location.href ="/admin/order/order-management?uiNum="+uiNum;
}
function getMemberInfo(pageNum,Obj){
  
  page = pageNum;
  
	if(countSearch!=0){
		search(page)
		return;
	}
	
  if(Obj!=null){
    //activePageButton(Obj);
  }
  axios.get('/inquery',{
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
function getGrades(){
  axios.get('/grades')
  .then(response => {
    printData(response.data);
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
      //'<td><a href="" onclick="popupUserDetail()">' + setTypeIcon(user.uiType) +' '+ user.uiEmail +'</a></td>' +
    row.innerHTML = 
      '<td><input type="checkbox" onclick="check(this)" class="check" value="'+user.uiNum+'" name="uiNum"></td>' +
      '<td>' + user.credat + '</td>' +
      '<td>' + user.uiLastName+user.uiFirstName + '</td>' +
      '<td>' + setTypeIcon(user.uiType) +' '+ user.uiEmail +'</td>' +
      '<td>' + type(user.uiType) + '</td>' +
      '<td>' + user.giName + '</td>' +
      '<td>' + user.uiPhone + '</td>' +
      '<td>' + getGender(user.uiGender) + '</td>' +
      '<td>' +
        //'<button class="btn btn-icon btn-link-success avtar-xs"><i class="ph-duotone ph-envelope"></i></button>' +
        //'<button class="btn btn-icon btn-link-success avtar-xs"><i class="ph-duotone ph-messenger-logo"></i></button>' +
        '<button class="btn btn-icon btn-link-warning avtar-xs" onclick="memo('+user.uiNum+')" data-bs-toggle="modal" data-bs-target="#modal"><i class="ph-duotone ph-notepad"></i></button>' +
      '</td>' +
      '<td>' +
        '<button type="button" class="btn btn-outline-primary btn-sm" onclick="goOrderPage('+user.uiNum+')">주문</button>' +
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
    html += '<a class="page-link" onclick="getMemberInfo(' + (startNum - 1) + ')" tabindex="-1">Previous</a>';
    html += '</li>';
  }

  // 페이지 번호 표시
  for (var i = startNum; i <= lastNum; i++) {

    if (i === page) {
      html += '<li class="page-item page-nums"><button class="page-link" onclick="getMemberInfo(' + i + ',$(this))">' + i + '</button></li>';  // 현재 페이지는 active 클래스 추가
    } else {
      html += '<li class="page-item page-nums"><button class="page-link" onclick="getMemberInfo(' + i + ',$(this))">' + i + '</button></li>';
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
function setType(typeNumber){
	const checkedObjs = document.querySelectorAll('input[name=uiNum]');
  const param = [];
  // 선택된 체크박스들의 정보를 param 배열에 담기
  checkedObjs.forEach(checkedObj => {
    if (checkedObj.checked) {
      param.push({
        uiNum: checkedObj.value,
        uiType: typeNumber
      });
    }
  });
  
  // Axios로 PUT 요청 보내기
  axios.put('/admin-users', param, {
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(response => {
    alert(response.data+"명의 회원 등급을 변경하였습니다.");
    search(page);
    //location.href="/admin/user/search";
  })
  .catch(error => {
    console.error('There was an error!', error);
    alert('There was an error processing your request.');
  });
}
function setOut(){
	const checkedObjs = document.querySelectorAll('input[name=uiNum]');
  const param = [];
  // 선택된 체크박스들의 정보를 param 배열에 담기
  checkedObjs.forEach(checkedObj => {
    if (checkedObj.checked) {
      param.push({
        uiNum: checkedObj.value
      });
    }
  });
  
  // Axios로 PUT 요청 보내기
  axios.put('/admin-users2', param, {
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(response => {
    alert(response.data+"명의 회원 정보를 삭제하였습니다.");
    search(page);
  })
  .catch(error => {
    console.error('There was an error!', error);
    alert('There was an error processing your request.');
  });
}
function search(page){
	let memberType =  document.querySelector('input[name="memberType"]:checked');
	const searchType = document.querySelector('#searchType').value;
	const searchText = document.querySelector('#searchText').value;
	let searchGrade = document.querySelector('#searchGrade').value;
	let gender =  document.querySelector('input[name="gender"]:checked');
  
  const start=  document.querySelector('input[name="range-start"]').value;
  const end=  document.querySelector('input[name="range-end"]').value;
  
  //console.log("memberType:"+memberType);
  if(memberType!=null){
    memberType = memberType.value;
  }
  //console.log("gender:"+gender);
  if(gender!=null){
    gender = gender.value;
  }
  let uiLastName, uiFirstName, uiEmail, uiPhone,uiGender,giNum,uiType;
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
  searchGrade = searchGrade==0 ? null: searchGrade;
  uiType = memberType==3 ? null: memberType;
  uiGender = gender==3 ? null: gender;
  giNum = searchGrade==''? null:searchGrade;
	
	const param = {
    uiLastName : uiLastName,
    uiFirstName : uiFirstName,
    uiEmail :uiEmail, 
    uiPhone:uiPhone,
    uiType:uiType,
    giNum:giNum,
    uiGender:uiGender,
    uiStartDate: start,
    uiEndDate:end,
    count: itemsPerPage,
    page: page
  };
	if( chk(uiLastName) && chk(uiFirstName) && chk(uiEmail) &&
	 chk(uiPhone) && chk(uiType) && chk(giNum) && chk(uiGender) && chk(start) && chk(end)){
		countSearch = 0;
	}else{
		countSearch++;
	}
	axios.post('/inquery2', param, {
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
function popupUserDetail(){
  // 사용자 화면 크기 가져오기
  var screenWidth = window.innerWidth;  // 화면의 너비
  var screenHeight = window.innerHeight;  // 화면의 높이

  // 팝업창의 크기 계산 (화면 너비의 85%, 화면 높이의 85%)
  var popupWidth = screenWidth * 0.7;
  var popupHeight = screenHeight * 0.85;

  // 팝업창이 정확히 중앙에 오도록 left, top 계산
  var left = (screenWidth - popupWidth) / 2;  // 중앙 정렬 (좌측 여백)
  var top = (screenHeight - popupHeight) / 2;  // 중앙 정렬 (상단 여백)

  // 팝업창 열기
  window.open("/admin/user/detail", "popupWindow", 
              "width=" + popupWidth + ",height=" + popupHeight + 
              ",left=" + left + ",top=" + top + ",resizable=yes");
}