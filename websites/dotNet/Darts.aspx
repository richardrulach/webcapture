<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Darts.aspx.cs" Inherits="_Default" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Darts</title>
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

    </script>

</head>
<body>
    <form id="form1" runat="server">
    
        <div>Game:</div>
        <div>
            Target: <input id="target" type="text" />
        </div>
        <div>
            Return to old game: 
            <select>
                <option></option>
            </select>
        </div>
        <div>
            <input type="button" value="Start" />
        </div>

        <div>Players:</div>
        <div>
            New player name: <input type="text" />
        </div>        
        <div>
            select new players here:
            <div><input type="checkbox" id="player1" /><label for="player1">Richard</label></div>
        </div>

        <div>Game:</div>
    </form>
</body>
</html>
