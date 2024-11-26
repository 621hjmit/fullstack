let userObject = null;
window.onload = init;
function init(){
  if(!user){
    location.href='/views/user/login';
  }else{
    userObject = Object.fromEntries(
      user.match(/(\w+)=([^,]+)/g).map(pair => pair.split('='))
    );
    getData('#boardList');
  }
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
function getData(elementID){
  const param = {
    uiNum       :   userObject.uiNum
  }
  
  axios.post('/board-contact', param, {
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(res => {
    res = res.data;
    let htmlContent ='';
    for (let i = 0; i < res.length; i++) {
      const item = res[i];
      htmlContent += 
        '<tr>'+
          '<td class="ta-center"><input type="checkbox" onclick="check(this)" class="check" value="'+item.ubNum+'" name="ubNum"></td>' +
          '<td class="ta-center m-hidden">'+ item.ucTitle + '</td>'+
          '<td><a href="/views/user/board-contact-view?ubNum='+item.ubNum+'">'+ item.ubTitle + '</a></td>'+
          '<td class="ta-center m-hidden">'+ item.ubCredat + '</td>'+
          '<td class="ta-center ">'+ item.ubReply + '</td>'+
        '</tr>';
    }
    document.querySelector(elementID).innerHTML += htmlContent;
  })
  .catch(error => {
    console.error('There was an error!', error);
    alert('There was an error processing your request.');
  });
}
function deleteInquiryRecord(){
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
  
  // Axios로 PUT 요청 보내기
  axios.post('/board-contact2', param, {
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(response => {
    alert(response.data+"개의 1:1 문의내역을 삭제하였습니다.");
    location.href="/views/user/board-contact";
  })
  .catch(error => {
    console.error('There was an error!', error);
    alert('There was an error processing your request.');
  });
}