// ==UserScript==
// @name         Save selected text
// @namespace    http://dev129.com/
// @version      0.2
// @description  Saves pairs of question and answer to webservice
// @author       Richard Rulach
// @match        https://docs.microsoft.com/en-us/sql/*
// @match        https://www.safaribooksonline.com/library/*
// @grant        GM_xmlhttpRequest
// @grant        GM_addStyle
// ==/UserScript==

var modal, span, modalText, bInEditor, prefix;

(function() {
    'use strict';

    var css = " \
.modal { \
    display: none; \
    position: fixed; \
    z-index: 1; \
    left: 0;\
    top: 0;\
    width: 100%; \
    height: 100%; \
    overflow: auto; \
    background-color: rgb(0,0,0); \
    background-color: rgba(0,0,0,0.4); \
}\
\
.modal-content {\
    background-color: #fefefe;\
    margin: 15% auto; \
    padding: 20px;\
    border: 1px solid #888;\
    width: 80%; \
}\
\
.rrClose {\
    color: #aaa;\
    float: right;\
    font-size: 28px;\
    font-weight: bold;\
}\
\
.rrClose:hover,\
.rrClose:focus {\
    color: black;\
    text-decoration: none;\
    cursor: pointer;\
} \
    ";
    GM_addStyle(css);
    
    var body = document.getElementsByTagName('body')[0];
    body.innerHTML = body.innerHTML + '<div id="myModal" class="modal"><div class="modal-content"><span id="rrClose">&times;</span><div>Prefix: <input type="text" id="txtPrefix" /> <span id="spanClearPrefix">clear</span></div><div id="modalText" contenteditable="true"></></div></div>';
    
    modal = document.getElementById('myModal');
    modalText = document.getElementById('modalText');
    span = document.getElementById('rrClose');
    bInEditor = false;
    
    prefix = document.getElementById('spanClearPrefix');
    
    span.onclick = function() {
        modal.style.display = "none";
        bInEditor = false;
    };

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
            bInEditor = false;
        }
    };

    prefix.onclick = function(){
        document.getElementById('txtPrefix').value = '';
    };
    
    document.onmouseup = function(){
        //console.log(window.getSelection().toString());
        var selObj = window.getSelection();
        var sHighlightedText = selObj.toString();
        var allText = modalText.innerHTML;
        var range;
        

        
        // GET THE LATEST RANGE OBJECT
        for (var i = 0; i < selObj.rangeCount; i++) {
            range = selObj.getRangeAt(i);
        }
        
        if ((bInEditor)&&(sHighlightedText.length > 0)){

            var sQuestion = document.getElementById('txtPrefix').value + 
               allText.substring(0, selObj.anchorOffset) +
               sHighlightedText.replace(/[^\s]{1}/gi, '_') +
               allText.substring(selObj.anchorOffset + sHighlightedText.length);

            SaveText(sQuestion,sHighlightedText);

            modal.style.display = "none";
            bInEditor = false;

        } else if ((!bInEditor)&&(sHighlightedText.length > 0)){
            modalText.innerText = sHighlightedText.replace(/\r\n/gi,'');
            modal.style.display = "block";
            bInEditor = true;
        }

    };


    
})();

/*
CODE FOR SIDEKICK...

document.body.innerHTML += '<div id="rr_menu">one</div>'; 
var rrMenu = document.getElementById('rr_menu');
rrMenu.style.position = 'fixed';
rrMenu.style.padding = '20px';
rrMenu.style.height = '100px';
rrMenu.style.width ='400px';
rrMenu.style.top = 0;
rrMenu.style.left = 0;
rrMenu.style.zIndex = '5000';
rrMenu.style.backgroundColor = 'white';

rrMenu.style.display = 'block';


*/



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
