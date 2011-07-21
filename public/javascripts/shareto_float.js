﻿-
function () {
    var d = document,
        isStrict = d.compatMode == "CSS1Compat",
        dd = d.documentElement,
        db = d.body,
        m = Math.max,
        na = navigator.userAgent.toLowerCase(),
        ie = !! d.all,
        head = d.getElementsByTagName('head')[0],
        getWH = function () {
            return {
                h: (isStrict ? dd : db).clientHeight,
                w: (isStrict ? dd : db).clientWidth
            }
        },
        getS = function () {
            return {
                t: m(dd.scrollTop, db.scrollTop),
                l: m(dd.scrollLeft, db.scrollLeft)
            }
        },
        creElm = function (o, t, a) {
            var b = d.createElement(t || 'div');
            for (var p in o) {
                p == 'style' ? b[p].cssText = o[p] : b[p] = o[p]
            }
            return (a || db).insertBefore(b, (a || db).firstChild)
        },
        div, div1 = creElm({
            style: "height:auto;position:absolute;z-index:100000;display:none;top:50%;left:50%;overflow:auto;"
        }),
        inputTimer, list, clist, as, texts = {},
        script, timerover, timerout, timerloop, loop = function () {
            var t = 1000,
                st = getS().t,
                c, wh = getWH();
            c = st - div.offsetTop + (wh.h / 2 - sharetoFloatContain.pop.offsetWidth / 2);
            c != 0 && (div.style.top = div.offsetTop + c / 10 + 'px', t = 10);
            timerloop = setTimeout(loop, t)
        },
        iframe = creElm({
            style: 'position:' + (/firefox/.test(na) ? 'fixed' : 'absolute') + ';display:none;',
            frameBorder: 0
        }, 'iframe'),
        conf = {
            align: 'right',
            move: '1'
        },
        scripts = d.getElementsByTagName('script');
    for (var i = 0, ci; ci = scripts[i++];) {
        if (/shareto_float.js/.test(ci.src)) {
            ci.src.replace(/(align|color|move)=([^&]+)/g, function (a, p, v) {
                conf[p] = v
            });
            break;
        }
    };
    div = creElm({
        style: "height:auto;position:" + (conf.move != '0' || /msie 6/i.test(na) ? 'absolute' : 'fixed') + ";z-index:100000000;top:" + (conf.move != '0' || /msie 6/i.test(na) ? '0' : '150px') + ";" + (conf.align == 'right' ? "right:0;overflow:hidden;width:26px;" : "left:-242px;overflow:auto;"),
        innerHTML: conf.align == 'right' ? "<table cellPadding=0 cellSpacing=0 ><tbody style='background:transparent'><tr><td style='background:transparent' ><img name='shareto_float_btn' src=http://shareto.googlecode.com/svn/trunk/img/" + (conf.color?'r'+conf.color+'.gif':'r0.gif') + " style='cursor:pointer;' onmouseover='sharetoFloatContain.over()' onclick='sharetoFloatContain.center(this)'/></td><td><div ></div></td></tr></tbody></table>" : "<table cellPadding=0 cellSpacing=0 ><tbody style='background:transparent'><tr><td><div ></div></td><td><img name='shareto_float_btn' src=http://shareto.googlecode.com/svn/trunk/img/" +(conf.color?'l'+conf.color+'.gif':'l0.gif') + " style='cursor:pointer;' onmouseover='sharetoFloatContain.over()' onclick='sharetoFloatContain.center(this)'/></td></tr></tbody></table>"
    });
    creElm({
        href: 'http://shareto.googlecode.com/svn/trunk/css/css1.css',
        rel: 'stylesheet',
        type: 'text/css'
    }, 'link');
    d.write('<script src="http://share-to-anywhere.googlecode.com/svn/trunk/www/shareto_float_menu.js" charset="utf-8"></script><script src="http://share-to-anywhere.googlecode.com/svn/trunk/www/shareto_float_window.js" charset="utf-8"></script>');
    sharetoFloatContain = {
        pop: div.getElementsByTagName('div')[0],
        centerpop: div1,
        disappear: function (a) {
            var b = window.event || a,
                t = b.srcElement || b.target,
                contain = div1.contains ? div1.contains(t) : !! (div1.compareDocumentPosition(t) & 16),
                contain1 = div.contains ? div.contains(t) : !! (div.compareDocumentPosition(t) & 16);
            if (!contain && !contain1) {
                iframe.style.display = div1.style.display = 'none';
            }
        },
        over: conf.align == 'right' ?
        function () {
            if (div.offsetWidth > 26) return;
            clearTimeout(timerloop);
            clearInterval(timerout);
            div.style.cssText += ";height:" + this.pop.offsetHeight + "px;width:26px;left:" + (getWH() - 26) + "px";
            var t = 10,
                tmp = 0,
                step = this.pop.offsetWidth / 55;
            timerover = setInterval(function () {
                if (t == 0) {
                    clearInterval(timerover);
                    (conf.move != '0' || /msie 6/i.test(na)) && loop()
                } else {
                    var n = Math.round(step * t--);
                    div.style.left = div.offsetLeft - n + 'px';
                    div.style.width = div.offsetWidth + n + 'px'
                }
            }, 10)
        } : function () {
            clearTimeout(timerloop);
            clearInterval(timerout);
            clearInterval(timerover);
            var t = 10,
                tmp = 0,
                step = Math.abs(div.offsetLeft / 55);
            timerover = setInterval(function () {
                if (t == 0) {
                    clearInterval(timerover);
                    (conf.move != '0' || /msie 6/i.test(na)) && loop()
                } else {
                    var n = Math.round(step * t--);
                    div.style.left = div.offsetLeft + n + 'px'
                }
            }, 10)
        },
        out: conf.align == 'right' ?
        function () {
            if (div.offsetWidth > sharetoFloatContain.pop.offsetWidth) {
                clearInterval(timerover);
                clearTimeout(timerloop);
                div.style.cssText += ";height:" + sharetoFloatContain.pop.offsetHeight + "px;width:" + (sharetoFloatContain.pop.offsetWidth + 26) + "px;left:" + (getWH() - 26 - sharetoFloatContain.pop.offsetWidth) + "px";
                var t = 10,
                    tmp = 0,
                    step = (div.offsetWidth - 26) / 55;
                timerout = setInterval(function () {
                    if (t == 0) {
                        clearInterval(timerout);
                        div.style.left = '';
                        (conf.move != '0' || /msie 6/i.test(na)) && loop()
                    } else {
                        var n = Math.round(step * t--);
                        div.style.width = div.offsetWidth - n < 26 ? 26 : div.offsetWidth - n + 'px';
                        div.style.left = div.offsetLeft + n + 'px'
                    }
                }, 10)
            }
        } : function () {
            clearInterval(timerover);
            clearInterval(timerout);
            clearTimeout(timerloop);
            var t = 10,
                tmp = 0,
                step = Math.abs((div.offsetLeft + 242) / 55);
            timerout = setInterval(function () {
                if (t == 0) {
                    clearInterval(timerout);
                    div.style.left = '-242px';
                    (conf.move != '0' || /msie 6/i.test(na)) && loop()
                } else {
                    var n = Math.round(step * t--);
                    div.style.left = div.offsetLeft - n + 'px'
                }
            }, 10)
        },
        center: function (a) {
            if (a) {
                db.style.position = 'static';
                var b = getS();
                div1.style.display = "block";
                div1.style.margin = (-div1.offsetHeight / 2 + b.t) + "px " + (-div1.offsetWidth / 2 + b.l) + "px";
                list = d.getElementById('ckelist');
                clist = list.cloneNode(true);
                as = clist.getElementsByTagName('input');
                for (var i = 0, ci; ci = as[i++];) {
                    texts[ci.value] = ci.parentNode
                };
                with(iframe.style) {
                    left = top = '50%';
                    width = div1.offsetWidth + 'px';
                    height = div1.offsetHeight + 'px';
                    margin = div1.style.margin;
                    display = 'block'
                }
            }
        },
        choose: function (o) {
            clearTimeout(inputTimer);
            inputTimer = setTimeout(function () {
                var s = o.value.replace(/^\s+|\s+$/, ''),
                    frag = d.createDocumentFragment();
                for (var p in texts) {
                    eval("var f = /" + (s || '.') + "/ig.test(p)");
                    f && frag.appendChild(texts[p].cloneNode(true))
                }
                list.innerHTML = '';
                list.appendChild(frag)
            }, 100)
        },
        centerClose: function () {
            iframe.style.display = div1.style.display = 'none'
        }
    };
    if (ie) {
        div.onmouseleave = sharetoFloatContain.out;
        d.attachEvent("onclick", sharetoFloatContain.disappear)
    } else {
        div.onmouseout = function (e) {
            !(this === e.relatedTarget || (this.contains ? this.contains(e.relatedTarget) : this.compareDocumentPosition(e.relatedTarget) == 20)) && sharetoFloatContain.out.call(this)
        };
        d.addEventListener("click", sharetoFloatContain.disappear, false)
    };
    (conf.move != '0' || /msie 6/i.test(na)) && loop()
	document.write('<script src="http://shareto.googlecode.com/svn/trunk/js/analytics.js"></script>');
}();
function share_to(m) {
	if (m == "baidu") {
		window
				.open('http://cang.baidu.com/do/add?it='
						+ encodeURIComponent(document.title.substring(0, 76))
						+ '&iu=' + encodeURIComponent(location.href)
						+ '&fr=ien#nw=1', 'baidu',
						'scrollbars=no,width=600,height=450,status=no,resizable=yes,left='
						+ (screen.width - 600) / 2 + ',top='
						+ (screen.height - 450) / 2);
	} else if (m == "qq") {
		window
				.open(
						'http://shuqian.qq.com/post?from=3&title='
								+ encodeURIComponent(document.title) + '&uri='
								+ encodeURIComponent(document.location.href)
								+ '&jumpback=2&noui=1',
						'favit',
						'width=930,height=470,toolbar=no,menubar=no,location=no,scrollbars=yes,status=yes,resizable=yes,left='
						+ (screen.width - 930) / 2 + ',top='
						+ (screen.height - 470) / 2);
	} else if (m == "tsina") {
		void ((function(s, d, e) {
			try {
			} catch (e) {
			}
			var f = 'http://v.t.sina.com.cn/share/share.php?', u = d.location.href, p = [
					'url=', e(u), '&title=', e(d.title), '&appkey=330242870' ]
					.join('');
			function a() {
				if (!window
						.open(
								[ f, p ].join(''),
								'mb',
								[
										'toolbar=0,status=0,resizable=1,width=620,height=450,left=',
										(s.width - 620) / 2, ',top=',
										(s.height - 450) / 2 ].join('')))
					u.href = [ f, p ].join('');
			}
			;
			if (/Firefox/.test(navigator.userAgent)) {
				setTimeout(a, 0)
			} else {
				a()
			}
		})(screen, document, encodeURIComponent));
	} else if (m == "douban") {
		void (function() {
			var d = document, e = encodeURIComponent, s1 = window.getSelection, s2 = d.getSelection, s3 = d.selection, s = s1 ? s1()
					: s2 ? s2() : s3 ? s3.createRange().text : '', r = 'http://www.douban.com/recommend/?url='
					+ e(d.location.href)
					+ '&title='
					+ e(d.title)
					+ '&sel='
					+ e(s) + '&v=1', x = function() {
				if (!window
						.open(r, 'douban',
								'toolbar=0,resizable=1,scrollbars=yes,status=1,width=450,height=355,left='
									+ (screen.width - 450) / 2 + ',top='
									+ (screen.height - 330) / 2))
					location.href = r + '&r=1'
			};
			if (/Firefox/.test(navigator.userAgent)) {
				setTimeout(x, 0)
			} else {
				x()
			}
		})();
	} else if (m == "renren") {
		// 官方分享方式1
//		var connect_url = "http://www.connect.renren.com";
//		var url = window.location.href;
//		var addQS = function(url, qs) {
//			var a = [];
//			for ( var k in qs)
//				if (qs[k])
//					a.push(k.toString() + '=' + encodeURIComponent(qs[k]));
//			return url + '?' + a.join('&');
//		}
//		var href = addQS(connect_url + '/sharer.do', {
//			'url' : url,
//			'title' : url == window.location.href ? document.title : null
//		});
//		window.open(href, 'sharer',
//				'toolbar=0,status=0,width=550,height=400,left='
//						+ (screen.width - 550) / 2 + ',top='
//						+ (screen.height - 500) / 2);

		// 官方分享方式2
		 void ((function(s, d, e) {
		 if (/renren\.com/.test(d.location))
		 return;
		 var f = 'http://share.renren.com/share/buttonshare.do?link=', u =
		 d.location, l = d.title, p = [
		 e(u), '&title=', e(l) ].join('');
		 function a() {
		 if (!window
		 .open(
		 [ f, p ].join(''),
		 'xnshare',
		 [
		 'toolbar=0,status=0,resizable=1,width=626,height=436,left=',
		 (s.width - 626) / 2, ',top=',
		 (s.height - 436) / 2 ].join('')))
		 u.href = [ f, p ].join('');
		 }
		 ;
		 if (/Firefox/.test(navigator.userAgent))
		 setTimeout(a, 0);
		 else
		 a();
		 })(screen, document, encodeURIComponent));
	} else if (m == "kaixin001") {
		var kw = window
				.open(
						'',
						'kaixin001',
						'toolbar=no,titlebar=no,status=no,menubar=no,scrollbars=no,location:no,directories:no,width=570,height=350,left='
								+ (screen.width - 570)
								/ 2
								+ ',top='
								+ (screen.height - 420) / 2);
		var tempForm = kw.document.createElement('form');
		function openPostWindow(url, data, name) {
			var tempForm = document.createElement('form');
			tempForm.id = 'tempForm1';
			tempForm.method = 'post';
			tempForm.action = url;
			tempForm.target = 'kaixin001';
			var hideInput = document.createElement('input');
			hideInput.type = 'hidden';
			hideInput.name = 'rcontent';
			hideInput.value = data;
			tempForm.appendChild(hideInput);
			document.body.appendChild(tempForm);
			tempForm.submit();
			document.body.removeChild(tempForm);
		}
		function add2Kaixin001() {
			var u = document.location.href;
			var t = document.title;
			var c = '' + (document.getSelection ? document.getSelection()
					: document.selection.createRange().text);
			var iframec = '';
			var url = 'http://www.kaixin001.com/repaste/bshare.php?rtitle='
					+ encodeURIComponent(t) + '&rurl=' + encodeURIComponent(u)
					+ '&from=maxthon';
			var data = encodeURIComponent(c);
			openPostWindow(url, c, '_blank')
		}
		add2Kaixin001();
	} else if (m == "google") {
		void (function() {
			var a = window, b = document, c = encodeURIComponent, d = a
					.open(
							'http://www.google.com/bookmarks/mark?op=edit&hl=zh-CN&output=popup&bkmk='
									+ c(b.location) + '&title=' + c(b.title),
							'bkmk_popup',
							'left='
									+ ((a.screenX || a.screenLeft) + 10)
									+ ',top='
									+ ((a.screenY || a.screenTop) + 10)
									+ ',height=420px,width=550px,resizable=1,alwaysRaised=1');
			a.setTimeout(function() {
				d.focus()
			}, 300)
		})();
	} else if (m == "taojianghu") {
		window.open("http://share.jianghu.taobao.com/share/addShare.htm?url="
				+ encodeURIComponent(document.location.href), 'taojianghu',
				'toolbar=0,status=0,width=550,height=400,left='
						+ (screen.width - 550) / 2 + ',top='
						+ (screen.height - 500) / 2);
	} else if (m == "gmail") {
		var a = window, b = document, c = encodeURIComponent;
		var w = window.open(
				"https://mail.google.com/mail/?view=cm&fs=1&tf=1&ui=2&shva=1&to&su="
						+ c(b.title) + "&body=" + c(b.location), 'gmail',
				'width=' + (window.innerWidth * 0.57) + ',height='
						+ (window.innerHeight * 4 / 5) + ',left='
						+ ((a.screenX || a.screenLeft) + 10) + ',top='
						+ ((a.screenY || a.screenTop) + 10));
	} else if (m == "yahoo") {
		window
				.open('http://myweb.cn.yahoo.com/popadd.html?url='
						+ encodeURIComponent(document.location.href)
						+ '&title=' + encodeURIComponent(document.title),
						'Yahoo',
						'scrollbars=yes,width=440,height=440,left=80,top=80,status=yes,resizable=yes');

	} else if (m == "douban9") {
		void (function() {
			var d = document, e = encodeURIComponent, s1 = window.getSelection, s2 = d.getSelection, s3 = d.selection, s = s1 ? s1()
					: s2 ? s2() : s3 ? s3.createRange().text : '', r = 'http://www.douban.com/recommend/?url='
					+ e(d.location.href)
					+ '&title='
					+ e(d.title)
					+ '&sel='
					+ e(s) + '&v=1&n=1', x = function() {
				if (!window
						.open(r, 'douban9',
								'toolbar=0,resizable=1,scrollbars=yes,status=1,width=450,height=330'))
					location.href = r + '&r=1'
			};
			if (/Firefox/.test(navigator.userAgent)) {
				setTimeout(x, 0)
			} else {
				x()
			}
		})();
	} else if (m == "115") {
		var sel = '' + (document.getSelection ? document.getSelection()
				: document.selection.createRange().text);
		var url = document.location.href;
		var title = document.title;
		var c = encodeURIComponent;
		void (window.open('http://fav.115.com/?ac=add&title=' + c(title)
				+ '&url=' + c(url) + '&c=' + c(sel), '115',
				'toolbar=0,status=0,width=780,height=700,left='
						+ (screen.width - 780) / 2 + ',top='
						+ (screen.height - 700) / 2));
	} else if (m == "51") {
		try {
			var w = window.open(
					"http://share.51.com/share/share.php?type=8&title="
							+ encodeURIComponent(document.title) + '&vaddr='
							+ encodeURIComponent(document.location), '51',
					'toolbar=0,status=0,width=780,height=700,left='
							+ (screen.width - 780) / 2 + ',top='
							+ (screen.height - 700) / 2);
			window.opener.focus();
		} catch (e) {
		}
	} else if (m == "tsohu") {// 非官方
		void ((function(s, d, e) {
			var f = 'http://t.sohu.com/third/post.jsp?link=', u = d.location;
			function a() {
				if (!window
						.open(
								[ f, e(u) ].join(''),
								'tsohu',
								[
										'toolbar=0,status=0,resizable=1,width=660,height=470,left=',
										(s.width - 660) / 2, ',top=',
										(s.height - 470) / 2 ].join('')))
					u.href = [ f, e(u) ].join('');
			}
			;
			if (/Firefox/.test(navigator.userAgent))
				setTimeout(a, 0);
			else
				a();
		})(screen, document, encodeURIComponent));
	} else if (m == "leshou") {
		window
				.open('http://leshou.com/post?act=shou&reuser=&url='
						+ encodeURIComponent(location.href) + '&title='
						+ encodeURIComponent(document.title)
						+ '&intro=&tags=&tool=1', 'leshou',
						'scrollbars=yes,width=700,height=500,left=80,top=80,status=no,resizable=yes');
		return false;
	} else if (m == "vivi") {
		var sel = '' + (document.getSelection ? document.getSelection()
				: document.selection.createRange().text);
		var url = document.location.href;
		var title = document.title;
		void (window
				.open('http://vivi.sina.com.cn/collect/icollect.php?title='
						+ escape(title) + '&url=' + escape(url) + '&desc='
						+ escape(sel), '_blank',
						'scrollbars=no,width=480,height=480,left=75,top=50,status=no,resizable=yes'))
	} else if (m == "bai") {
		void ((function(s, d, e) {
			var f = 'http://bai.sohu.com/share/blank/addbutton.do?link=', u = d.location, l = d.title, p = [
					e(u), '&title=', e(l) ].join('');
			function a() {
				if (!window
						.open(
								[ f, p ].join(''),
								'sohushare',
								[
										'toolbar=0,status=0,resizable=1,width=480,height=340,left=',
										(s.width - 480) / 2, ',top=',
										(s.height - 340) / 2 ].join('')))
					u.href = [ f, p ].join('');
			}
			;
			if (/Firefox/.test(navigator.userAgent))
				setTimeout(a, 0);
			else
				a();
		})(screen, document, encodeURIComponent));
	} else if (m == "qzone") {// 未开放分享
		window.open(
				"http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url="
						+ encodeURIComponent(document.location), 'qzone',
				'toolbar=0,status=0,width=900,height=760,left='
						+ (screen.width - 900) / 2 + ',top='
						+ (screen.height - 760) / 2);
	} else if (m == "live") {
		window
				.open(
						"https://skydrive.live.com/sharefavorite.aspx/.SharedFavorites/?marklet=1&mkt=zh-CN&top=1&url="
								+ encodeURIComponent(document.location)
								+ "&title="
								+ encodeURIComponent(document.title), 'live',
						'toolbar=0,status=0,width=850,height=530,left='
								+ (screen.width - 850) / 2 + ',top='
								+ (screen.height - 530) / 2);
	} else if (m == "greader") {
		var b = document.body;
		var GR________bookmarklet_domain = 'http://www.google.com';
		if (b && !document.xmlVersion) {
			void (z = document.createElement('script'));
			void (z.src = 'http://www.google.com/reader/ui/link-bookmarklet.js');
			void (b.appendChild(z));
		} else {
		}
	} else if (m == "itieba") {// 未开放分享
		var sendT = {
			getContent : function() {
				var allPageTagss = document.getElementsByTagName("div");
				for ( var i = 0; i < allPageTagss.length; i++) {
					if (allPageTagss[i].className == 'content') {
						return allPageTagss[i].innerHTML;
					} else if (allPageTagss[i].className == 'content_txt') {

						return allPageTagss[i].getElementsByTagName("P")[0].innerHTML;
					}

				}
			}
		}
		var itieba_share = 'http://tieba.baidu.com/i/sys/share?link='
				+ encodeURIComponent(window.location.href) + '&type='
				+ encodeURIComponent('text') + '&title='
				+ encodeURIComponent(document.title.substring(0, 76))
				+ '&content=' + encodeURIComponent(sendT.getContent());
		if (!window
				.open(itieba_share, 'itieba',
						'toolbar=0,resizable=1,scrollbars=yes,status=1,width=626,height=436')) {
			location.href = itieba_share;
		}
	} else if (m == "hexun") {
		var t = document.title;
		var u = location.href;
		var e = document.selection ? (document.selection.type != 'None' ? document.selection
				.createRange().text
				: '')
				: (document.getSelection ? document.getSelection() : '');
		void (window.open('http://bookmark.hexun.com/post.aspx?title='
				+ escape(t) + '&url=' + escape(u) + '&excerpt=' + escape(e),
				'HexunBookmark',
				'scrollbars=no,width=600,height=580,status=no,resizable=yes,left='
						+ (screen.width - 600) / 2 + ',top='
						+ (screen.height - 580) / 2));
	} else if (m == "t163") {// 待完善--非官方
		(function() {
			var url = 'link=http://www.shareto.com.cn/&source='
					+ encodeURIComponent('网易新闻   ') + '&info='
					+ encodeURIComponent(document.title) + ' '
					+ encodeURIComponent(document.location.href);
			window
					.open(
							'http://t.163.com/article/user/checkLogin.do?'
									+ url + '&' + new Date().getTime(),
							't163',
							'height=330,width=550,top='
									+ (screen.height - 280)
									/ 2
									+ ',left='
									+ (screen.width - 550)
									/ 2
									+ ', toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
		})()
	} else if (m == "xianguo") {
		void (function() {
			var d = document, e = encodeURIComponent, s1 = window.getSelection, s2 = d.getSelection, s3 = d.selection, s = s1 ? s1()
					: s2 ? s2() : s3 ? s3.createRange().text : '', r = 'http://xianguo.com/service/submitfav/?link='
					+ e(d.location.href)
					+ '&title='
					+ e(d.title)
					+ '&notes='
					+ e(s), x = function() {
				if (!window
						.open(r + '&r=0', 'xgfav',
								'toolbar=0,resizable=1,scrollbars=yes,status=1,width=800,height=600'))
					location.href = r + '&r=1'
			};
			if (/Firefox/.test(navigator.userAgent)) {
				setTimeout(x, 0)
			} else {
				x()
			}
		})()
	} else if (m == 'hotmail') {
		window.open("http://mail.live.com/secure/start?action=compose&subject="
				+ encodeURIComponent(document.title) + "&body="
				+ encodeURIComponent(document.location.href), 'hotmail',
				'toolbar=0,status=0,width=1010,height=700,left='
						+ (screen.width - 1010) / 2 + ',top='
						+ (screen.height - 700) / 2);
	} else if (m == "delicious") {
		(function() {
			f = 'http://delicious.com/save?url='
					+ encodeURIComponent(window.location.href) + '&title='
					+ encodeURIComponent(document.title) + '&v=5&';
			a = function() {
				if (!window
						.open(f + 'noui=1&jump=doclose', 'deliciousuiv5',
								'location=yes,links=no,scrollbars=no,toolbar=no,width=550,height=550'))
					location.href = f + 'jump=yes'
			};
			if (/Firefox/.test(navigator.userAgent)) {
				setTimeout(a, 0)
			} else {
				a()
			}
		})()
	} else if (m == "digg") {
		window.open("http://digg.com/submit?type=0&url="
				+ encodeURIComponent(window.location.href), 'digg',
				'toolbar=0,status=0,width=965,height=700,left='
						+ (screen.width - 965) / 2 + ',top='
						+ (screen.height - 700) / 2);
	} else if (m == "translate") {
		// 网页内翻译
		// var d = document;
		// var b = d.body;
		// var v = b.insertBefore(d.createElement('div'), b.firstChild);
		// v.id = 'google_translate_element';
		// v.style.display = 'none';
		// var z = d.createElement('script');
		// z.src =
		// 'http://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit';
		// b.appendChild(z);
		// 新窗口翻译
		var t = ((window.getSelection && window.getSelection())
				|| (document.getSelection && document.getSelection()) || (document.selection
				&& document.selection.createRange && document.selection
				.createRange().text));
		var e = (document.charset || document.characterSet);
		if (t != '') {
			window.open('http://translate.google.cn/?text=' + t
					+ '&hl=zh-CN&langpair=auto|zh-CN&tbb=1&ie=' + e,
					'gtranslate');
		} else {
			window.open('http://translate.google.cn/translate?u='
					+ encodeURIComponent(location.href)
					+ '&hl=zh-CN&langpair=auto|zh-CN&tbb=1&ie=' + e,
					'gtranslate');
		}
		;
	} else if (m == "buzz") {
		window
				.open(
						"http://www.google.com/buzz/post?hl=zh-CN&url="
								+ encodeURIComponent(window.location.href),
						'buzz',
						"width=716,height=480,location=yes,scrollbars=yes,menubar=no,toolbar=no,dialog=yes,alwaysRaised=yes");
	} else if (m == "pdf") {
		var authorId = "ECF83C2F-F3A3-45DE-8A44-2A36A9A9A1FB";
		var pageOrientation = "1";
		var topMargin = "0.5";
		var bottomMargin = "0.5";
		var leftMargin = "0.5";
		var rightMargin = "0.5";
		function savePageAsPDF() {
			var sUriRequest = "";

			sUriRequest = "author_id=" + authorId;
			sUriRequest += "&page=" + pageOrientation;
			sUriRequest += "&top=" + topMargin;
			sUriRequest += "&bottom=" + bottomMargin;
			sUriRequest += "&left=" + leftMargin;
			sUriRequest += "&right=" + rightMargin;

			// savepageaspdf.pdfonline.com
			var pURL = "http://savepageaspdf.pdfonline.com/pdfonline/pdfonline.asp?cURL="
					+ escape(document.location.href) + "&" + sUriRequest;
			window
					.open(pURL, "PDFOnline",
							"scrollbars=yes,resizable=yes,width=920,height=800,menubar,toolbar,location");
		}
		savePageAsPDF();
	} else if (m == "hi") {
		window
		.open(
				'http://apps.hi.baidu.com/share/?url=' + encodeURIComponent(location.href)+ '&title='
				+ encodeURIComponent(document.title),
				'baiduhi',
				'scrollbars=no,width=820,height=550,status=no,resizable=yes,left='
						+ (screen.width - 820) / 2 + ',top='
						+ (screen.height - 550) / 2);
	} else if (m == "reddit") {
		var href = 'http://www.reddit.com/submit?url='
				+ encodeURIComponent(location.href) + '&title='
				+ encodeURIComponent(document.title);
		window.open(href, 'reddit',
				'toolbar=0,status=0,width=900,height=740,left='
						+ (screen.width - 900) / 2 + ',top='
						+ (screen.height - 740) / 2);
	} else if (m == "t139") {
		window.open('http://www.139.com/share/share.php?title='
				+ encodeURIComponent(document.title) + '&url='
				+ encodeURIComponent(location.href), 't139',
				'width=490,height=340,left=' + (screen.width - 490) / 2
						+ ',top=' + (screen.height - 340) / 2);
	} else if (m == "myspace") {
		(function() {
			window.open(
					'http://www.myspace.cn/Modules/PostTo/Pages/DefaultMblog.aspx?t='
							+ encodeURIComponent(document.title) + '&u='
							+ encodeURIComponent(location.href)
							+ '&source=bookmark', 'myspace',
					'width=495,height=450,resizable=yes,left='
							+ (screen.width - 495) / 2 + ',top='
							+ (screen.height - 450) / 2);
		})();
	} else if (m == "ymail") {
		window.open("http://compose.mail.yahoo.com/?subject="
				+ encodeURIComponent(document.title) + "&body="
				+ encodeURIComponent(document.location), 'ymail',
				'toolbar=0,status=0,width=760,height=670,left='
						+ (screen.width - 760) / 2 + ',top='
						+ (screen.height - 670) / 2);
	} else if (m == "csdn") {
		var d = document;
		var t = d.selection ? (d.selection.type != 'None' ? d.selection
				.createRange().text : '') : (d.getSelection ? d.getSelection()
				: '');
		void (saveit = window
				.open('http://wz.csdn.net/storeit.aspx?t=' + escape(d.title)
						+ '&u=' + escape(d.location.href) + '&c=' + escape(t),
						'csdn',
						'scrollbars=no,width=600,height=310,status=no,resizable=yes,left='
						+ (screen.width - 600) / 2 + ',top='
						+ (screen.height - 310) / 2));
		saveit.focus();
	} else if (m == "youdao") {
		void (window
				.open(
						'http://shuqian.youdao.com/manage?a=popwindow&title='
								+ encodeURI(document.title) + '&url='
								+ encodeURI(document.location),
						'youdao',
						'height=200, width=590,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no,left='
						+ (screen.width - 590) / 2 + ',top='
						+ (screen.height - 200) / 2));
	} else if (m == "tqq") {
		var _t = encodeURI(document.title);
		var _url = encodeURIComponent(document.location);
		var _appkey = encodeURI("appkey");//你从腾讯获得的appkey
		var _pic = encodeURI('');//（例如：var _pic='图片url1|图片url2|图片url3....）
		var _site = '';//你的网站地址
		var _u = 'http://v.t.qq.com/share/share.php?url='+_url+'&appkey='+_appkey+'&site='+_site+'&pic='+_pic+'&title='+_t;
		window.open( _u,'', 'width=700, height=680, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, location=yes, resizable=no, status=no' );
	}

	// 33twwiter,facebook,digu,有道,白社会(mop),csdn
	// 待开发:和讯微博
	return false;
}
// function googleTranslateElementInit() {
// new google.translate.TranslateElement({}, 'google_translate_element');
// }
function st_addBookmark(title){
    var url = parent.location.href;
    if (window.sidebar) { // Mozilla Firefox Bookmark
        window.sidebar.addPanel(title, url,"");
    } else if(document.all) { // IE Favorite
        window.external.AddFavorite( url, title);
    } else if(window.opera) { // Opera 7+
        return false; // do nothing
    } else { 
         alert('请按 Ctrl + D 为chrome浏览器添加书签!');
    }
}