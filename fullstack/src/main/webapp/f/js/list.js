

const $productsFilter = $ ('.products-filter');
const $switchInput = $('.switch-input');
const $switchInputDefault = $('.switch-input').prev();
const $container=$('.prd-list');
const $loadMoreBtn=$('.moreBtn');
let $addItemCount=24;
let $added=0;
let $allData=[];
let $filter=$('#product-filter');
let $filterData=[];
let index;

var pcFlag;
var prditemSetpositionFlag;
//첨에 윈도우 불러왔을때 실행 영역 ----------------
//addItem() //get jason할때 실행되고 있다.
checkDevice(); 
fliterSwitch(); //필터 모바일 피씨 디자인 변경

$filter.on('change', '#online-switch', filterItems);
// $(".width-size").html($(this).width());
setTimeout(function(){
    if(!$('.prd-item').length){
        //alert('Open with live server 로 열어주세요.');
        var html = $(".prd-list").html();
        html = html.replace("<!--","");
        html = html.replace("-->","");
        $(".prd-list").html(html);
        setTimeout(function(){
            if(pcFlag&&!prditemSetpositionFlag){ //모바일에서 피씨로 바뀌였고, 정렬된 적이 한번도 없으면 전부 다시 정렬해야함.
                index = 0;
                prditemSetposition2();
            }
        },100);
        $(".moreBtn").hide();
    }
    //data-url 가져와보쟈
    $(".prd-item").each(function(i){
        let str = $(this).children('.prd-carousel').attr('data-imagesurl');
        //console.log(str);
    });
    
},100);
$('.filterNavButton').click(function(){
    $('#filterBox').addClass('block');
    $('#filterBox').removeClass('flex');
    $('#filterBox').removeClass('hide');
    $(this).addClass('clicked');
    $('html').css('overflow','hidden');
    return false;
});

$('#filterClose .nav-close').click(function(){
    $('#filterBox').removeClass('block');
    $('#filterBox').addClass('hide');
    $('.filterNavButton').removeClass('clicked');
    $('html').css('overflow','scroll');
    return false;
});

$("#oneVisibleBtn").click(function(){
    //한줄로보기
    $(".prd-list").addClass('oneLine');
    $(".prd-list").removeClass('twoLine');
    $('#one').prop("checked", true);
    $('#two').prop("checked", false);
    return false;//button html 코드를 실행하지 마라고 하는 것.
});

$("#twoVisibleBtn").click(function(){
    //두줄로보기
    $(".prd-list").removeClass('oneLine');
    $(".prd-list").addClass('twoLine');
    $('#one').prop("checked", false);
    $('#two').prop("checked", true);
    return false;
});


$switchInput.click(function(){
    $switchInputDefault.click();
});

$('.dropdown-btn').click(function(e){
    if(!$(this).hasClass('open')){
        $('.dropdown-btn.open').removeClass('open');
        $('.dropdown.open').removeClass('open');
        $('.dropdown').hide();
    }else{
    }
    $(this).toggleClass('open')
    $(this).next().slideToggle(100);
    e.preventDefault();
});

$('.custom-input[type=button]').click(function(){
    $(this).toggleClass('checked'); //사이즈 버튼에 checked 라는 클래스 넣어서 효과를 준다.
    return false;
});

$.getJSON('./data/product.json',function(data){
    $allData=data;
    // console.log(data);
    $filterData=$allData;
    addItem();
    $loadMoreBtn.click(function(){
        addItem();
    });
    //$filter.on('change', 'input[type="radio"]', filterItems)
});

//-------------------------------------------------



//윈도우 리사이즈시 실행 영역 ---------------------

$( window ).on( "resize", function() {
    checkDevice();
    fliterSwitch();
    // $(".width-size").html($(this).width());
    
    if(pcFlag&&!prditemSetpositionFlag){ //모바일에서 피씨로 바뀌였고, 정렬된 적이 한번도 없으면 전부 다시 정렬해야함.
        prditemSetpositionAll()
    }
    if(!pcFlag&&prditemSetpositionFlag){
        $(".prd-item").removeClass('space');    //피씨에서 모바일로 바뀌였고, 정렬된 적이 있다면  space 를 다 뺀다. 여백 없애기.
        console.log('remove all space');
    }
    
});

//-------------------------------------------------


function checkDevice(){
    if($(window).width()>802){
        pcFlag= true;
    }else{
        pcFlag=false;
    }
}

function addItem(){
    let element=[];
    let slicedData;
    index = $added;
    slicedData=$filterData.slice($added, $added+=$addItemCount);

    $.each(slicedData, function(index, item){
        let itemHTML=` 
            <a href="detail.html" class="prd-item ${item.class}">
            <div class="prd-image"><img src="product/${item.imgurl}"></div>
            <div class="prd-carousel" data-imagesurl="${item.imagesurl}"></div>
            <div class="prd-meta">
               <p class="prd-name">${item.name}</p>
               <p class="prd-color sr-only">, 컬러:  ${item.color}</p>
               <p class="prd-price"><span class="sr-only">, </span>₩ ${item.price}</p>
            </div>
         </a>
        `
        element.push($(itemHTML).get(0)); //ㅗ
        
        

        if($added<$allData.length){
            $loadMoreBtn.show();
        }else{
            $loadMoreBtn.remove();
        }

        $container.append(element);

    })
    setTimeout(function(){
        if(pcFlag){
            prditemSetposition() //addItem 했을때 정렬하는 곳.피씨면 정렬한다.
        }else{
            $(".prd-item").removeClass('space');    //모바일이면  space를 다뺀다. 
        }
    },100);
}

function prditemSetpositionAll(){
    index = 0;
    prditemSetposition();
}

function prditemSetposition2(){
    $added = $(".prd-item").length;
    $(".prd-item").each(function(i){
        let $this = $(this);
        if( i> index && i < $added){
            let position;
            position = $this.offset();
            position = position.left - 24;
            if($this.hasClass('prd-item-large')){
                //space를 어따줄지를 계산한다.
                if(position>0){
                    $this.prev().addClass('space');
                }else{
                    $this.addClass('space');
                }
            }
        }
    });
    prditemSetpositionFlag = true;
}
function prditemSetposition(){
    
        $(".prd-item").each(function(i){
            let $this = $(this);
            if( i> index && i < $added){
                let position;
                position = $this.offset();
                position = position.left - 24;
                if($this.hasClass('prd-item-large')){
                    //space를 어따줄지를 계산한다.
                    if(position>0){
                        $this.prev().addClass('space');
                    }else{
                        $this.addClass('space');
                    }
                }
                console.log(i);
            }
        });
        prditemSetpositionFlag = true;
        console.log('prditemSetpositionFlag = true;');
}
function filterItems(){
    let checked = $(this).is(':checked');
    let key=$(this).val();
    $filterData=[];
    $added=0;
    $container.empty();
    if(checked==false){
        $filterData=$allData;
     }else{
        $filterData=$.grep($allData, function(item){
            return item.line===key;
        })
    }
    index=0;  //data 처음부터 부른다는 의미
    $('.space').removeClass('space');
    addItem(true);
}

function fliterSwitch() {  
    //필터 버튼이 보였다 안보였다. 한다.<--css에서 주관되고있음. 
    //#filterBox 모바일화도 한다.
    //801px 사이즈에서 필터 버튼이 보인다.
    if(!pcFlag) {  
        //모바일
        $productsFilter.addClass('mobile');
        $('#filterBox').removeClass('flex');
        if($('.filterNavButton').hasClass('clicked')){
            $('#filterBox').addClass('block')
        }else{
            $('#filterBox').addClass('hide');
        }
        //$('#filterBox').css('display','flex').hide();
    }else{
        //피씨
        if($('.filterNavButton').hasClass('clicked')){
            $('#filterBox').removeClass('block');    
        }
        $('#filterBox').removeClass('hide');
        $productsFilter.removeClass('mobile');
        $('#filterBox').addClass('flex');
    }
}
