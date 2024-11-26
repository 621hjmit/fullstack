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
  getList(page);
  period();
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

function setTotalResults(totalItems){
	const resultElements = document.querySelectorAll(".totalResults");
  resultElements.forEach(element => {
      element.textContent = `${totalItems}`;
  });
}

function getList(pageNum,Obj){

  page = pageNum;
  
  const start=  document.querySelector('input[name="range-start"]').value;
  const end=  document.querySelector('input[name="range-end"]').value;

  if( chk(start) && chk(end) ){
    countSearch = 0;
  }else{
    countSearch++;
  }
  const param = {
     count: itemsPerPage,
     page: page,
     uiStartDate: start,
     uiEndDate:end
  };
  axios.post('/best-user',param) // API URL을 실제 엔드포인트로 변경
  .then(response => {
    //console.table(response.data);
    getListData(response);
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
    /*
    O.OR_NUM, O.CREDAT, U.UI_LAST_NAME, U.UI_FIRST_NAME, U.UI_EMAIL,
         G.GI_NAME, O.OR_ID, O.OR_AMOUNT
         U.UI_EMAIL, U.UI_FIRST_NAME, U.UI_LAST_NAME, U.UI_PHONE, SUM(O.OR_AMOUNT) AS AMOUNT
         순위 이멜 이름 전번 주소 기간내 총 주문금액
    */
    row.innerHTML = 
      '<td>' + user.rowNumber + '</td>' +
      '<td>' + user.orRank + '</td>' +
      '<td>' + user.uiEmail +'</td>' +
      '<td>' + user.uiLastName+user.uiFirstName + '</td>' +
      '<td>' + user.uiPhone + '</td>' +
      '<td>' + user.aiAddress1 +' '+ user.aiAddress2 + '</td>' +
      '<td>' + user.orAmount + '</td>';
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

