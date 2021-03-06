﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Captured Text Editor</title>
    <style>

        .questions 
        {
            width:45%;
            float:left;
            border: 1px dashed grey; 
            padding:3px;
            margin:3px;
        }

        .answers 
        {
            padding-left: 15px;
            width:45%;
            float:left;
            border: 1px dashed grey; 
            padding:3px;
            margin:3px;
        }

        .qContainer 
        {
            clear:both;
            padding-top:20px;
        }

        #output 
        {
            clear:both;
            padding-top:40px;
        }

    </style>

    <script type="text/javascript" src="_js/jquery.js"></script>


    <script type="text/javascript">
        var allTextId = [];

        $(document).ready(function () {
            $('#listContainer').html('');
            loadData();

            setInterval(loadData, 1000);

        });

        function loadData()
        {
            $.get("_srv/WebService.asmx/GetText", function (data) {

                var xDoc = $(data).find('string').text();
                var obj = JSON.parse(xDoc);

                for (var i = 0; i < obj.length; i++) {
                    //console.log(obj[i].id + " = " + obj[i].text);

                    if (!allTextId.includes(obj[i].id)) {
                        allTextId.push(obj[i].id);
                        $('#listContainer').append('<div class="qContainer"><div class="questions" contenteditable="true">' + obj[i].text + '</div>' + 
                            '<div class="answers" contenteditable="true"> </div>' +
                            '<input type="button" onclick="addToPrevious(this)" value="Add to previous" />' +
                            '<input type="button" onclick="deleteElem(this)" value="delete" />' +
                            '<input type="button" onclick="flip(this)" value="flip" />' +
                            '</div>');
                        $('#listContainer > .qContainer').last().data('id', obj[i].id);
                        AddEvent($('#listContainer > .qContainer').last());
                    } else {
                        //console.log('already contains: ' + obj[i].id);
                    }
                }

            });
        }

        function addToPrevious(elem) {
            var sText = $(elem).parent().find('.questions').text();
            $(elem).parent().prev().find('.answers').text(sText);
            $(elem).parent().remove();
        }

        function deleteElem(elem) {
            $(elem).parent().remove();
        }

        function flip(elem) {
            var sQuestion = $(elem).parent().find('.questions').text();
            var sAnswer = $(elem).parent().find('.answers').text();
            $(elem).parent().find('.questions').text(sAnswer);
            $(elem).parent().find('.answers').text(sQuestion);
        }

        function AddEvent(element) {
            element.mouseup(function (e) {
                if ($('#rdEditMode').prop('checked') != true) {

                    var selObj = window.getSelection();
                    var selectedText = selObj.toString();
                    var allText = $(e.target).text();
                    var range;

                    if (selectedText.length == 0) return;

                    // GET THE LATEST RANGE OBJECT
                    for (var i = 0; i < selObj.rangeCount; i++) {
                        range = selObj.getRangeAt(i);
                    }

                    $(e.target).text(allText.substring(0, range.startOffset) +
                                        selectedText.replace(/[^\s]{1}/gi, '_') +
                                        allText.substring(range.endOffset));

                    $(e.target).next().text(selectedText);

                    generateOutput();
                }
            });
        }


        function generateOutput() {
            var s = '';
            $('.questions').each(function (i, e) {
                s += $(e).parent().find('.answers').text() + '|' + $(e).text() + '¬';
            });
            $('#output').text(s);
            copyToClipboard($('#output'));
        }


        function copyToClipboard(element) {
            var $temp = $("<input>");
            $("body").append($temp);
            $temp.val($(element).text()).select();
            document.execCommand("copy");
            $temp.remove();
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    
    <div>
        <input type="radio" id="rdEditMode" name="rdEdit" value="0" /> Edit 
        &nbsp;&nbsp;&nbsp;&nbsp;
        <input type="radio" id="rdBlankMode" name="rdEdit" value="1" checked="checked" /> Insert blanks
    </div>
    <div>
        <h1>capturedText editor</h1>
        <div></div>

        <div id="listContainer"></div>
    
    </div>

    <div id="output">
    </div>
    <div>
        <input type="button" onclick="generateOutput()" value="Generate" />
    </div>
    </form>
</body>
</html>
