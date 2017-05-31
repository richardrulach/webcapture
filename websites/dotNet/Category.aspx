<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Category.aspx.cs" Inherits="Category" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Category</title>
    <link type="text/css" rel="stylesheet" href="_css/main.css" />
    <link type="text/css" rel="stylesheet" href="_css/hierarchyEditor.css" />
    <script type="text/javascript" src="_js/jquery.js"></script>
</head>
<body>
    <header>
        <ul>
            <li><a href="Default.aspx">HOME</a></li>
            <li><a href="Tools.aspx">TOOLS</a></li>
            <li><a href="Category.aspx">CATEGORY</a></li>
            <li><a href="Export.aspx">EXPORT</a></li>
            <li><a href="About.aspx">ABOUT</a></li>
        </ul>
    </header>
    <form id="form1" runat="server">
    
    <div>
        <div id="display">
            COntent
        </div>

        <div id="editor">
            <div class="editorContainer">
                <input type="text" id="nameEditor" />
            </div>
            <div class="editorContainer">
                <textarea id="txtMultiEditor"></textarea>
            </div>
        </div>
    </div>
        
    </form>
</body>
</html>
