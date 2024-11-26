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
  getOrderUserList(page);
  getGrades();
}
function setPage(){
	let str = document.querySelector(".page-header-title>h2").textContent;
	document.title = str + " | Hermes Admin";
  /*
  const datepicker_range = new DateRangePicker(document.querySelector('#datepicker_range'), {
    buttonClass: 'btn',
    format: "yyyymmdd"
  });
  */
}

function setPaginationActive(){
  const paginationNumber = page - 1;
  $('.page-nums.active').removeClass('active');
  $('.page-nums').eq(paginationNumber).addClass('active');
}
function setCount(Obj){
  itemsPerPage = Obj.value;
  getOrderUserList(page);
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

$('#userPhone').on('input', function() {
    // 현재 입력값을 가져옴
    let value = $(this).val();

    // 첫 글자가 0인 경우 제거
    if (value.startsWith('0')) {
        value = value.slice(1);
    }

    // '-' 문자를 제거
    value = value.replace(/-/g, '');

    // 수정된 값을 다시 설정
    $(this).val(value);
});
/* DB에서 데이터를 가져오는 함수들 영역*/
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

function chk(str){
	return (str=='' || str==null);
}
function getOrderUserList(pageNum,Obj){
  page = pageNum;
  //검색조건이 있게 검색을 한 경우에는... 전체값을 불러오면 안되니까. search() 함수를 통해서 그 값으로 리스트를 불러온다.
	if(countSearch!=0){
		search(page)
		return;
	}
  if(Obj!=null){
    //activePageButton(Obj);
  }
  axios.get('/order-user',{
    params: {
       count: itemsPerPage,
       page: page
    }
  }) // API URL을 실제 엔드포인트로 변경
  .then(response => {
    //alert(response.data);
    getListData(response);
  })
  .catch(error => {
    console.error('Error fetching statistics:', error);
  });
}
/*
function activePageButton($obj) {
  // 기존의 active 클래스를 가진 요소에서 active 클래스를 제거
  $('.page-item.active').removeClass('active');
  
  // 새로 클릭한 요소의 부모 요소에 active 클래스를 추가
  $obj.parent().addClass('active');
  console.log($obj.parent().attr('class')); // 확인용 출력
  return;
}
*/
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
  const userList = document.querySelector('#orderUserList'); // 테이블의 tbody 요소
  userList.innerHTML ='';
  const users = response.data.list; // List<StatisticsVO> 데이터를 받아옴
  totalItems = response.data.count; // List<StatisticsVO> 데이터를 받아옴
  users.forEach(user => {
    const row = document.createElement('tr');
    /*
    O.OR_NUM, O.CREDAT, U.UI_LAST_NAME, U.UI_FIRST_NAME, U.UI_EMAIL,
         G.GI_NAME, O.OR_ID, O.OR_AMOUNT
    */
    row.innerHTML = 
      '<td><input type="checkbox" onclick="check(this)" class="check" value="'+user.uiNum+'" name="uiNum"></td>' +
      '<td>' + user.orCredat + '</td>' +
      '<td>' + user.uiLastName+user.uiFirstName + '</td>' +
      '<td>' + setTypeIcon(user.uiType) +' '+ user.uiEmail +'</td>' +
      '<td>' + user.giName + '</td>' +
      '<td>' + type(user.uiType) + '</td>' +
      '<td>' + user.orId + '</td>' +
      '<td>' + user.orAmount + '</td>' +
      '<td>' + user.orCount + '</td>' +
      '<td>' +
        //'<button class="btn btn-icon btn-link-success avtar-xs"><i class="ph-duotone ph-envelope"></i></button>' +
        //'<button class="btn btn-icon btn-link-success avtar-xs"><i class="ph-duotone ph-messenger-logo"></i></button>' +
        '<button class="btn btn-icon btn-link-warning avtar-xs" onclick="memo('+user.uiNum+')" data-bs-toggle="modal" data-bs-target="#modal"><i class="ph-duotone ph-notepad"></i></button>' +
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
    html += '<a class="page-link" onclick="getOrderUserList(' + (startNum - 1) + ')" tabindex="-1">Previous</a>';
    html += '</li>';
  }

  // 페이지 번호 표시
  for (var i = startNum; i <= lastNum; i++) {

    if (i === page) {
      html += '<li class="page-item active"><button class="page-link" onclick="getOrderUserList(' + i + ',$(this))">' + i + '</button></li>';  // 현재 페이지는 active 클래스 추가
    } else {
      html += '<li class="page-item"><button class="page-link" onclick="getOrderUserList(' + i + ',$(this))">' + i + '</button></li>';
    }
  }

  // 다음 페이지 버튼 (lastNum이 totalNum과 다르면 활성화)
  if (lastNum < totalNum) {
    html += '<li class="page-item">';
    html += '<a class="page-link" onclick="getOrderUserList(' + (lastNum + 1) + ')">Next</a>';
    html += '</li>';
  }

  html += '</ul>';

  document.querySelector('#pagination').innerHTML = html;
  setPaginationActive();
  
}
function setType(typeNumber){
  const checkedObjs = document.querySelectorAll('input[name=uiNum]');
  const type = typeNumber;
  const param = [];
  // 선택된 체크박스들의 정보를 param 배열에 담기
  checkedObjs.forEach(checkedObj => {
    if (checkedObj.checked) {
      param.push({
        uiNum: checkedObj.value,
        uiType: type
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
    location.href="/admin/user/search";
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
    location.href="/admin/user/search";
  })
  .catch(error => {
    console.error('There was an error!', error);
    alert('There was an error processing your request.');
  });
}
function searchUnorderedUser(page){
	let   searchGrade   = document.querySelector('#searchGrade').value;
  const userFirstName = document.querySelector('#userFirstName').value;
  const userLastName  = document.querySelector('#userLastName').value;
  const userPhone     = document.querySelector('#userPhone').value;
  const userEmail     = document.querySelector('#userEmail').value;
  const userOrderID   = document.querySelector('#userOrderID').value;
  const memberType=null; 
  
  searchGrade = searchGrade==0 ? null: searchGrade;
  
  const param = {
    uiLastName : userLastName,
    uiFirstName : userFirstName,
    uiEmail :userEmail,
    uiPhone : userPhone,
    uiType:memberType,
    giNum:searchGrade,
    orId: userOrderID,
    count: itemsPerPage,
    page: page
  };
	
	
	if( chk(userLastName) && chk(userFirstName) && chk(userEmail) &&
	 chk(userPhone) && chk(memberType) && chk(searchGrade) && chk(userOrderID)){
		countSearch = 0;
	}else{
		countSearch++;
	}
	
  axios.post('/order-user3', param, {
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
function search(page){
  let   memberType    = document.querySelector('input[name="memberType"]:checked');
  memberType = memberType ? memberType.value : null; 
	if(memberType==2){
		searchUnorderedUser(page);
		return;
	}
  let   searchGrade   = document.querySelector('#searchGrade').value;
  const userFirstName = document.querySelector('#userFirstName').value;
  const userLastName  = document.querySelector('#userLastName').value;
  const userPhone     = document.querySelector('#userPhone').value;
  const userEmail     = document.querySelector('#userEmail').value;
  const userOrderID   = document.querySelector('#userOrderID').value;
  
  searchGrade = searchGrade==0 ? null: searchGrade;
  memberType = memberType==null ? null: memberType;
  
  const param = {
    uiLastName : userLastName,
    uiFirstName : userFirstName,
    uiEmail :userEmail,
    uiPhone : userPhone,
    uiType:memberType,
    giNum:searchGrade,
    orId: userOrderID,
    count: itemsPerPage,
    page: page
  };
	
	
	if( chk(userLastName) && chk(userFirstName) && chk(userEmail) &&
	 chk(userPhone) && chk(memberType) && chk(searchGrade) && chk(userOrderID)){
		countSearch = 0;
	}else{
		countSearch++;
	}
	
  axios.post('/order-user2', param, {
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