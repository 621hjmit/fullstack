let userObject;

document.addEventListener('DOMContentLoaded', function () {
  init();
});

function init(){
  if(!user){
    //세션에 유저 없으면 로긴 페이지로 던진다.
    location.href='/views/user/login';
  }else{
    userObject = Object.fromEntries(
      user.match(/(\w+)=([^,]+)/g).map(pair => pair.split('='))
    );
  }
  getData(userObject.uiNum);
  
}
function getData(num){
  const param = {
    uiNum : num
  }
  const cof = {
    method    : 'post',
    url       : '/user1',
    json      : true,
    callback  : function(res){
      res=JSON.parse(res);
      fillData(res);
    },
    param     : JSON.stringify(param)
  }
  ajax(cof);
}
function fillData(user){
  for (let key in user) {
    // user 객체의 각 key에 해당하는 id를 가진 요소가 있을 경우
    let element = document.getElementById(key); // key에 해당하는 id를 가진 요소를 찾음
    if (element) { // 요소가 존재한다면
        element.textContent = user[key]; // 요소에 값을 넣어줌
    }
  }
  fixData();
}
function fixData(){
  //기본주소에 이름 전번 넣어야되서 이름이랑 폰 받아와서 넣는다.
  const name = document.querySelector("#uName").innerText;
  const phone = document.querySelector("#uPhone").innerText;
  //성별 생일 뉴스레터 구독여부의 값을... 사용자 친화적으로 바꾼다.
  const gender = document.querySelector("#uiGender").innerText;
  const news = document.querySelector("#uiNews").innerText;
  document.querySelector("#aName").innerText = name;
  document.querySelector("#aPhone").innerText = phone;
  if(gender>1){
    document.querySelector("#uiGender").innerText = '여성';
  }else{
    document.querySelector("#uiGender").innerText = '남성';
  }
  if(news>0){
    document.querySelector("#uiNews").innerText = '구독중';
  }else{
    document.querySelector("#uiNews").innerText = '구독 안함';
  }
}
