<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Export.aspx.cs" Inherits="Export" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="_js/jquery.js"></script>


    <script type="text/javascript">

        $(document).ready(function () {
//            copyToClipboard($('#txtOutput'));
        });


        function copyToClipboard(element) {
            var $temp = $("<input>");
            $("body").append($temp);
            $temp.val($(element).text()).select();
            document.execCommand("copy");
            $temp.remove();
        }

        function Copy() {
            copyToClipboard($('#txtOutput'));
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <input type="button" onclick="copyToClipboard(document.getElementById('txtOutput'))" value="Copy" />
    </div>
    <div id="txtOutput">
        <asp:Literal ID="LitOutput" runat="server" />
    </div>
    </form>
</body>
</html>
