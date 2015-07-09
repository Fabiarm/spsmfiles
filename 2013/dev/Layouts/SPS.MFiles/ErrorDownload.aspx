<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ErrorDownload.aspx.cs" Inherits="SPS.MFiles.Layouts.SPS.MFiles.ErrorDownload" DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <asp:HiddenField ID="hdfMessage" runat="server" Value="<%$Resources:SPS.MFiles,DownloadPage_Message%>" />
    <div style="width: 100%; height: 100%;">
        <asp:Label ID="lblMessage" runat="server" Width="485px" Text=""></asp:Label>
    </div>
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
    <SharePoint:EncodedLiteral ID="ltlPageTitle" runat="server" Text="<%$Resources:SPS.MFiles,DownloadPage_PageTitle%>" EncodeMethod='HtmlEncode' />
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
    <SharePoint:EncodedLiteral ID="ltlPageTitleInTitleArea" runat="server" Text="<%$Resources:SPS.MFiles,DownloadPage_PageTitleInTitleArea%>" EncodeMethod='HtmlEncode' />
</asp:Content>
