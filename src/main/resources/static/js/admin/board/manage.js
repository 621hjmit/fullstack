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
  getBoardList(page);
  period();
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
function setPaginationActive(){
  const paginationNumber = page - 1;
  $('.page-nums.active').removeClass('active');
  $('.page-nums').eq(paginationNumber).addClass('active');
}
function setCount(Obj){
  itemsPerPage = Obj.value;
  getBoardList(page);
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
function getBoardList(pageNum){
  page = pageNum;
  
  if(countSearch!=0){
    search(page)
    return;
  }
  const param = {
     count: itemsPerPage,
     page: page
  }
  axios.post('/boards',param, {
    headers: {
      'Content-Type': 'application/json'
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
  const element = document.querySelector('#list'); // 테이블의 tbody 요소
  element.innerHTML ='';
  const posts = response.data.list; // List<StatisticsVO> 데이터를 받아옴
  totalItems = response.data.count; // List<StatisticsVO> 데이터를 받아옴
  setTotalResults(totalItems);
  posts.forEach(post => {
    const row = document.createElement('tr');
    row.innerHTML = 
      '<td><input type="checkbox" onclick="check(this)" class="check" value="'+post.ubNum+'" name="ubNum"></td>' +
      '<td>' + post.ubRowNumber + '</td>' +
      '<td>' + post.ucTitle + '</td>' +
      '<td>' + post.ubTitle + '</td>' +
      '<td>' + post.ubReply +'</td>';
	    row.innerHTML += '<td><button type="button" class="btn btn-outline-secondary" onclick="preview('+ post.ubNum +')" data-bs-toggle="modal" data-bs-target="#modal">보기</button></td>';
		if(post.ubReply=='답변완료'){
    	row.innerHTML += '<td><button type="button" class="btn btn-outline-secondary" onclick="showReply('+ post.ubNum +')" data-bs-toggle="modal" data-bs-target="#modal">답변보기</button></td>';
		}else{
    	row.innerHTML += '<td><button type="button" class="btn btn-primary" onclick="reply('+ post.ubNum +')" data-bs-toggle="modal" data-bs-target="#modal">답변하기</button></td>';
		}
    row.innerHTML += '<td>' + post.uiLastName + post.uiFirstName + '</td>' + '<td>' + post.ubCredat + '</td>';
    element.appendChild(row);
  })
  if(element.length<1){
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
    html += '<a class="page-link" onclick="getBoardList(' + (startNum - 1) + ')" tabindex="-1">Previous</a>';
    html += '</li>';
  }

  // 페이지 번호 표시
  for (var i = startNum; i <= lastNum; i++) {

    if (i === page) {
      html += '<li class="page-item page-nums"><button class="page-link" onclick="getBoardList(' + i + ',$(this))">' + i + '</button></li>';  // 현재 페이지는 active 클래스 추가
    } else {
      html += '<li class="page-item page-nums"><button class="page-link" onclick="getBoardList(' + i + ',$(this))">' + i + '</button></li>';
    }
  }

  // 다음 페이지 버튼 (lastNum이 totalNum과 다르면 활성화)
  if (lastNum < totalNum) {
    html += '<li class="page-item">';
    html += '<a class="page-link" onclick="getBoardList(' + (lastNum + 1) + ')">Next</a>';
    html += '</li>';
  }

  html += '</ul>';

  document.querySelector('#pagination').innerHTML = html;  
  setPaginationActive();
}
function search(page){
  const searchType = document.querySelector('#searchType').value;
  const searchText = document.querySelector('#searchText').value;
  let status =  document.querySelector('input[name="replyStatus"]:checked');
  const start=  document.querySelector('input[name="range-start"]').value;
  const end=  document.querySelector('input[name="range-end"]').value;
  
  if(status!=null){
    status = status.value;
  }
	///여기 아래부터 볼 것.
  let ubFirstName, ubLastName, ubEmail, ubPhone, ubTitle, ubMessage;
  
  if(searchType==1){
    ubTitle = searchText;
    ubTitle = ubTitle==''? null : ubTitle;
  }else if(searchType==2){
    ubMessage = searchText;
    ubMessage = ubMessage==''?null:ubMessage;
  }else if(searchType==3){
    ubLastName = searchText;
    ubLastName = ubLastName==''?null:ubLastName;
  }else if(searchType==4){
    ubFirstName = searchText;
    ubFirstName = ubFirstName==''?null:ubFirstName;
  }else if(searchType==5){
    ubEmail = searchText;
    ubEmail = ubEmail==''?null:ubEmail;
  }else if(searchType==6){
    ubPhone = searchText;
    ubPhone = ubPhone==''?null:ubPhone;
  }
  
  status = status==3 ? null: status;
  
  const param = {
    ubFirstName:ubFirstName,
    ubLastName:ubLastName, 
    ubEmail:ubEmail, 
    ubPhone:ubPhone, 
    ubTitle:ubTitle, 
    ubMessage: ubMessage,
    ubReply:status,
    ubStartDate: start,
    ubEndDate:end,
    count: itemsPerPage,
    page: page
  };
  if( chk(ubFirstName) && chk(ubLastName) && chk(ubEmail) &&
   chk(ubPhone) && chk(ubTitle) && chk(ubMessage) && chk(status) && chk(start) && chk(end)){
    countSearch = 0;
  }else{
    countSearch++;
  }
  axios.post('/boards', param, {
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
function preview(ubNum){
	document.querySelector("#modal-body").innerHTML = '';
	document.querySelector("#modal-body").innerHTML = '<div id="board_type"><dt>분류</dt><dd></dd></div><div id="board_title"><dt>제목</dt><dd></dd></div><div id="board_name"><dt>작성자</dt><dd></dd></div><div id="board_email"><dt>이메일</dt><dd></dd></div><div id="board_credat"><dt>작성일</dt><dd></dd></div><div id="board_content"><dt>고객의 메세지</dt><dd></dd></div>';
	const param = {
		ubNum : ubNum
	}
  axios.post('/adminboard', param, {
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(response => {
		console.log(response.data);
    modal(response.data);
		//cantact_board
  })
  .catch(error => {
    console.error('There was an error!', error);
    alert('There was an error processing your request.');
  });
}
function modal(data){
	document.querySelector(".modal-title").innerText = "게시글 내용 미리보기";
	document.querySelector("#board_type>dd").innerText = data.ucTitle;
	document.querySelector("#board_title>dd").innerText = data.ubTitle;
	document.querySelector("#board_name>dd").innerText = data.ubLastName + data.ubFirstName;
	document.querySelector("#board_email>dd").innerText = data.ubEmail;
	document.querySelector("#board_credat>dd").innerText = data.ubCredat;
	document.querySelector("#board_content>dd").innerText = data.ubMessage;
	document.querySelector(".modal-footer").innerHTML = '<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>';
}
function reply(ubNum){
	document.querySelector("#modal-body").innerHTML = '';
	document.querySelector(".modal-title").innerText = "답변 쓰기";
	document.querySelector("#modal-body").innerHTML = 
	'<textarea id="replyMessage" name="replyMessage" rows="20" cols="50" class="form-control"></textarea>';
	document.querySelector(".modal-footer").innerHTML = '';
	document.querySelector(".modal-footer").innerHTML += 
	'<button type="button" class="btn btn-primary" data-bs-dismiss="modal" onClick="saveReply('+ubNum+')">저장</button>';
}
function saveReply(ubNum){
	const param = {
		ubNum : ubNum,
		ubReplyMessage : document.querySelector("#replyMessage").value
	}
	axios.post('/adminboard2', param, {
	  headers: {
	    'Content-Type': 'application/json'
	  }
	})
	.then(response => {
		if(response.data=='1'){
			alert("답변등록 성공");
			getBoardList(page)
		}
	})
	.catch(error => {
	  console.error('There was an error!', error);
	  alert('There was an error processing your request.');
	});
}
function showReply(ubNum){
	document.querySelector("#modal-body").innerHTML = '';
	const param = {
		ubNum : ubNum
	}
  axios.post('/adminboard3', param, {
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(response => {
    showReplyMessage(response.data);
  })
  .catch(error => {
    console.error('There was an error!', error);
    alert('There was an error processing your request.');
  });
}
function showReplyMessage(data){
  document.querySelector(".modal-title").innerText = "답변 내용";
	document.querySelector("#modal-body").innerHTML = 
	'<textarea id="replyMessage" name="replyMessage" rows="20" cols="50" class="form-control">'+data.ubReplyMessage+'</textarea>';
	document.querySelector(".modal-footer").innerHTML =
		'<button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal" onClick="deleteReply('+data.ubNum+')">삭제</button>'+
		'<button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal" onClick="updateReply('+data.ubNum+')">수정</button>'+
		'<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>'; 
}
function deleteReply(ubNum){
  axios.put('/adminboard2/'+ubNum, {
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(res => {
		if(res.data==1){
	    alert("답변 삭제에 성공하였습니다.");
			getBoardList(page);
		}else{
			alert("답변 삭제에 실패하였습니다.");
		}
  })
  .catch(error => {
    console.error('There was an error!', error);
    alert('There was an error processing your request.');
  });
}
function updateReply(ubNum){
	const param = {
		ubNum : ubNum,
		ubReplyMessage : document.querySelector("#replyMessage").value
	}
	axios.put('/adminboard3/',param, {
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(res => {
		if(res.data==1){
	    alert("답변 수정에 성공하였습니다.");
			getBoardList(page);
		}else{
			alert("답변 수정에 실패하였습니다.");
		}
  })
  .catch(error => {
    console.error('There was an error!', error);
    alert('There was an error processing your request.');
  });
}
//다중삭제
function deleteSelected(){
	const checkedObjs = document.querySelectorAll('input[name=ubNum]');
  const param = [];
  // 선택된 체크박스들의 정보를 param 배열에 담기
  checkedObjs.forEach(checkedObj => {
    if (checkedObj.checked) {
      param.push({
        ubNum: checkedObj.value
      });
    }
  });
  
	if (param.length === 0) {
    alert("삭제할 항목을 선택하세요.");
    return;
  }

	// Axios로 DELETE 요청 보내기
  axios({
    method: 'delete',
    url: '/adminboard',
    data: param, // 본문 데이터를 여기에 전달
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(response => {
    alert(response.data+"개의 게시글을 삭제하였습니다.");
    search(page);
  })
  .catch(error => {
    console.error('There was an error!', error);
    alert('There was an error processing your request.');
  });
}