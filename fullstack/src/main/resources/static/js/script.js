// 사이트 전체 레이아웃 js
var slideFooterSpeed = 100;
var slideNavSpeed = 200;
var overlayNavSpeed = 200;

function showhideCallcenter() {
	//시각장애인을 위해 고객센터 html코드가 반복되지 않게 한다. 지웠다가 복붙해서 옮겼다가.... 그러는 것임.
	$(".footer-firstsection-undernavi").removeClass("open");
	$(".footer-firstsection-title").removeClass("minus");
	$copyofcard = $(".footer-card.hide-in-mobile");
	$pasteofcard = $(".footer-card.show-in-mobile");
	// 시각장애인 배려로 반복되는 문구는 없앤다. 에르메스 고객센터 부분.
	if ($(window).width() < 752) { //왜 768이 아닌건지 모르겠음.

		if ($pasteofcard.hasClass("cloned") === true) {
			// do nothing
		} else {
			html = $(".footer-card.hide-in-mobile").html();
			$pasteofcard.html(html);
			$pasteofcard.addClass("cloned");
			$copyofcard.html('');
		}
	} else {
		//웹버전
		if ($pasteofcard.hasClass("cloned") === true) {
			html = $(".footer-card.show-in-mobile").html();
			$pasteofcard.html('');
			$pasteofcard.removeClass("cloned");
			$copyofcard.html(html);
		} else {
			// do nothing
		}
	}
}


function openshutFooter() {
	const $ffs = $(".footer-firstsection-title");
	const $this = $ffs;
	const $undernavi = $this.next();
	let $exsist = null;
	let count = 0;
	$ffs.off().on("click", function(e){
		e.preventDefault();
		e.stopPropagation();
		count++;
		if ($(window).width() < 768) {
			//누른거 펼친다.
			$exsist = $('.minus');
			$(this).toggleClass("minus");
			$(this).next().slideToggle(slideFooterSpeed);
			//아코디언처럼 이미 열려있는 친구는 닫습니다.
			if ($exsist.length) {
				//닫는중
				$exsist.removeClass("minus");
				$exsist.next().slideUp(slideFooterSpeed);
			}
		} else {
			//웹버전
			$ffs.toggleClass("minus");
			$(".footer-firstsection-undernavi").slideToggle(slideFooterSpeed);
		}
	});
}
function shutFooterAll() {
	$(".footer-firstsection-undernavi").each(function() {
		$(this).slideUp(slideFooterSpeed);
		$(this).parent().removeClass("minus");
	});
}


function opensearch() {
	$("#menusearchWrap").addClass("openSearch");
	$("#recommendedSearchTerm").addClass("openSearch");
	$("#searchBackground").show();
} //opensearch

function closesearch() {
	
	$("#menusearchWrap").removeClass("openSearch");
	$("#recommendedSearchTerm").removeClass("openSearch");
	$("#searchBackground").hide();
} //closesearch

$("#searchTextArea").focus(function() {
	opensearch();
});
$("#searchTextArea").blur(function() {
	closesearch();
});
$("#menusearchMobile").click(function() {
	$("#searchTextArea").focus();
	opensearch();
});
$("#recommendedSearchTerm").click(function() {
	closesearch();
});
$("#searchBackground").click(function() {
	closesearch();
});

function push() {
	//메뉴열기
	$('#menu').off().on("click", function(e){
		e.preventDefault();
		$('body').css('overflow', 'hidden');
		$('body').css('padding-right', '17px');
		$('#navWrap').toggle();
		$('.nav').toggle("slide", { direction: "left" }, slideNavSpeed, function() {
			if ($(this).is(':visible')) {
				$(this).css('display', 'flex');
				$('.navfooterwrap').css('position', 'static');
			}
			$('.tray-overlay').fadeIn(overlayNavSpeed);
		});
	});

	$('.tray-overlay').off().on("click", function(e){
		closeNav();
	})
	$("#navClose .nav-close").off().on("click", function(e){
		closeNav();
	})
};
function closeNav() {
	//$('#navWrap').toggle();
	//$('#navWrap').animate({width:0},350);
	$('.nav').toggle("slide", { direction: "left" }, slideNavSpeed, function() {
		$('#navWrap').hide(function() {
			$('.tray-overlay').fadeOut(1);
		});
	});



	$('body').css('overflow', 'visible');
	$('body').css('padding-right', '0');
	$(".openSubnav").each(function() {
		$(this).removeClass("openSubnav");
	});
	$(".now").each(function() {
		$(this).removeClass("now");
	});


	var $firstNavi = $('.on');
	var $secondNavi = $('.on .on');
	var $thirdNavi = $('.on .on .on');

	$firstNavi.removeClass('on').find('ul').hide();
	$secondNavi.removeClass('on').find('ul').hide();
	$thirdNavi.removeClass('on').find('ul').hide();

};

function addComma() {
	$(".main_product_price").each(function() {
		var value = $(this).text();
		value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		$(this).text(value);
	});

}
function mainRowNaviFix() {
	//화면 맨위에 로고 라인 네비게이션을 스크롤 위치에 맞춰서  fix하는 스크립트
	var windowWidth = $(this).width();
	var windowScroll = $(this).scrollTop();
	let topNaviHeight = 29;

	if ($(window).width() < 752) {
		topNaviHeight = 0;
	}
	if (windowScroll >= topNaviHeight) {
		$("#mainRowNavi").addClass("fixed");
	} else {
		$("#mainRowNavi").removeClass("fixed");
	}

}
$(document).ready(function() {
	//푸터 첫번째 섹션 아코디언화...
	openshutFooter();

	//고객센터 위치조정 (윈도우 켰을 때)
	showhideCallcenter();
	push();//메뉴 연다.
	
	lnbUI.click('#mainNav li', 0);//메뉴속의 카테고리 메뉴를 누른다.
	addComma();//메인 상품 가격에 콤마 찍기
});

$(window).on("resize", function() {
	//고객센터 위치조정 (윈도우 리사이즈했을 때)
	showhideCallcenter();
	shutFooterAll();
	mainRowNaviFix();

});
$(window).scroll(function() {
	mainRowNaviFix();
});


var lnbUI = {
	click: function(target, speed) {
		var _self = this,
			$target = $(target);
		_self.speed = speed || 300;

		$target.each(function() {
			if (findChildren($(this))) {
				return;
			}
			$(this).addClass('noDepth');
		});

		function findChildren(obj) {
			return obj.find('> ul').length > 0;
		}
		var cnt =0;
		$target.unbind("click").bind("click", function(e) {
			
			e.stopPropagation();
			console.log(++cnt);
			
			var $this = $(this).children('a'),
				$depthTarget = $this.next(),
				$siblings = $this.parent().siblings();
				
			if ($this.parent().hasClass('noDepth')) {
				e.stopPropagation();
			}
			$this.parent('li').find('ul li').removeClass('on');
			$siblings.removeClass('on');
			$siblings.find('ul').slideUp(250);

			if ($depthTarget.css('display') == 'none') {
				_self.activeOn($this);
				$depthTarget.slideDown(_self.speed);
			} else {
				$depthTarget.slideUp(_self.speed);
				_self.activeOff($this);
			}

		})

	},
	activeOff: function($target) {
		$target.parent().removeClass('on');
	},
	activeOn: function($target) {
		$target.parent().addClass('on');
	}
};




