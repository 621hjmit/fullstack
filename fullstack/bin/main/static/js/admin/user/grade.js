/**
 * 
 *//**
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
  getList(page);
  getGrades();
}
function setPage(){
	let str = document.querySelector(".page-header-title>h2").textContent;
	document.title = str + " | Hermes Admin";
}

function setPaginationActive(){
  const paginationNumber = page - 1;
  $('.page-nums.active').removeClass('active');
  $('.page-nums').eq(paginationNumber).addClass('active');
}
function setCount(Obj){
	itemsPerPage = Obj.value;
	getList(page);
}
function chk(str){
	return (str=='' || str==null);
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
  if(number==1){
	  return "남성";
  }else if(number==2){
	  return "여성";
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
function printData(response, elementID){
  const gradeList = document.querySelector(elementID); // 테이블의 tbody 요소
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


function getList(pageNum,Obj){
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
    printData(response.data,'#searchGrade');
    printData(response.data,'#searchGrade2');
  })
  .catch(error => {
    console.error('Error fetching statistics:', error);
  });
}
function getListData(response){
  const userList = document.querySelector('#list'); // 테이블의 tbody 요소
  userList.innerHTML ='';
  const users = response.data.list; // List<StatisticsVO> 데이터를 받아옴
  totalItems = response.data.count; // List<StatisticsVO> 데이터를 받아옴
	setTotalResults(totalItems);
  users.forEach(user => {
    const row = document.createElement('tr');
    row.innerHTML = 
      '<td><input type="checkbox" onclick="check(this)" class="check" value="'+user.uiNum+'" name="uiNum"></td>' +
      '<td>' + user.credat + '</td>' +
      '<td>' + user.uiLastName+user.uiFirstName + '</td>' +
      '<td>' + setTypeIcon(user.uiType) +' '+ user.uiEmail +'</td>' +
      '<td>' + user.giName + '</td>' +
      '<td>' + type(user.uiGender) + '</td>' +
      '<td>' + user.uiPhone + '</td>' +
      //'<td>' +
        //'<button class="btn btn-icon btn-link-success avtar-xs"><i class="ph-duotone ph-envelope"></i></button>' +
        //'<button class="btn btn-icon btn-link-success avtar-xs"><i class="ph-duotone ph-messenger-logo"></i></button>' +
        //'<button class="btn btn-icon btn-link-warning avtar-xs"><i class="ph-duotone ph-notepad"></i></button>' +
      //'</td>' +
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
function search(page){
	let		 searchGrade 			= document.querySelector('#searchGrade').value;
	const  contactTypeSelect = document.querySelector('#contactTypeSelect').value;
	let 	 searchText 				= document.querySelector('#searchText').value;
	let		 email, uiLastName, uiFirstName, phone;
	
	if(contactTypeSelect==0){
    email = document.querySelector('#searchText').value;
		email = email==''?null:email;
  }else if(contactTypeSelect==1){
    uiLastName = document.querySelector('#searchText').value;
		uiLastName = uiLastName==''?null:uiLastName;
  }else if(contactTypeSelect==2){
    uiFirstName = document.querySelector('#searchText').value;
		uiFirstName = uiFirstName==''?null:uiFirstName;
  }else if(contactTypeSelect==3){
    phone = document.querySelector('#searchText').value;
		phone = phone==''?null:phone;
  }
	
  searchGrade = searchGrade==0 ? null: searchGrade; //0은 전체등급
	
	const param = {
    uiLastName : uiLastName,
    uiFirstName : uiFirstName,
    uiEmail :email, 
    uiPhone:phone,
    giNum:searchGrade,
    count: itemsPerPage,
    page: page
  };
	if( chk(uiLastName) && chk(uiFirstName) && chk(email) &&
	 chk(phone) && chk(searchGrade) ){
		countSearch = 0;
	}else{
		countSearch++;
	}
	console.table(param);
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


function updateGrades(){
	console.log("update function");
  const checkedObjs = document.querySelectorAll('input[name=uiNum]');
  const searchGrade = document.querySelector('#searchGrade2').value;
	console.log("searchGrade"+searchGrade);
  const param = [];
  for(const idx in checkedObjs){
    const checkedObj = checkedObjs[idx];
    if(checkedObj.checked){
      param.push({
        uiNum : checkedObj.value,
        giNum : searchGrade
      });
    }
  }
	axios.put('/users2', param, {
	  headers: {
	    'Content-Type': 'application/json'
	  }
	})
	.then(response => {
		alert(response.data+'명의 회원등급을 변경하였습니다.');
		location.href="/admin/user/grade";
	})
	.catch(error => {
	  console.error('There was an error!', error);
	  alert('There was an error processing your request.');
	});
}
function goOrderPage(uiNum){
  location.href ="/admin/order/order-management?uiNum="+uiNum;
}