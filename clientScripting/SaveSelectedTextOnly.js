// ==UserScript==
// @name         Save selected text only
// @namespace    http://dev129.com/
// @version      0.3
// @description  Saves pairs of question and answer to webservice
// @author       Richard Rulach
// @match        https://docs.microsoft.com/*
// @match        https://technet.microsoft.com/*
// @match        https://www.safaribooksonline.com/library/*
// @grant        GM_xmlhttpRequest
// @grant        GM_addStyle
// ==/UserScript==


(function() {
    'use strict';
	
   var elem = document.getElementsByClassName('annotator-adder')[0];
   if (elem) elem.parentNode.removeChild(elem);
  
   document.onmouseup = function(){
        var selObj = window.getSelection();
        var sHighlightedText = selObj.toString();
        SaveText(sHighlightedText,'');
      selObj.removeAllRanges();
    };

})();

function SaveText(q,a){
GM_xmlhttpRequest({
        method: "POST",
        url: "http://localhost:8028/_srv/WebService.asmx/SaveText",
        data:"question=" + encodeURI(q) + "&answer=" + encodeURI(a),
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        onerror: function(response) {
             alert(response.responseText);
        },
        onload: function(response) {
        //     alert(response.responseText);
        }
    });    
}
