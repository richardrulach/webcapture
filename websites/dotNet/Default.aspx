<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Captured Text Editor</title>
    <style>

        .questions 
        {
            width:45%;
            float:left;
        }

        .answers 
        {
            padading-left: 15px;
            width:45%;
            float:left;
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

        $(document).ready(function () {
            $("#listContainer").html('something');

            $.get("_srv/WebService.asmx/GetText", function (data) {

                $('#listContainer').html('');

                var xDoc = $(data).find('string').text();
                var obj = JSON.parse(xDoc);
                for (var i = 0 ; i < obj.length; i++) {
                    $('#listContainer').append('<div class="qContainer"><div class="questions" contenteditable="true">' + obj[i] + '</div><div class="answers"> </div></div>');
                }

                reloadEvents();
            });



        });

        function reloadEvents() {
            $(".questions").mouseup(function (e) {

                if ($('#rdEditMode').prop('checked') != true) {

                    var selObj = window.getSelection();
                    var selectedText = selObj.toString();
                    var allText = $(e.target).text();
                    var range;

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
                s += $(e).next().text() + '|' + $(e).text() + '¬';
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
    </form>
</body>
</html>
