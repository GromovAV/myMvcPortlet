<%@ page import="com.liferay.portal.kernel.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.liferay.portal.kernel.service.OrganizationLocalServiceUtil" %>
<%@ page import="com.liferay.portal.kernel.model.Organization" %>
<%@ page import="com.liferay.portal.kernel.model.Phone" %>
<%@ page import="com.liferay.portal.kernel.service.PhoneLocalServiceUtil" %>
<%@ page import="com.liferay.portal.kernel.model.Contact" %>
<%@ page import="java.text.DateFormatSymbols" %>
<%@ page import="java.util.Locale" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui" %>
<%@taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %>
<%@taglib uri="http://liferay.com/tld/security" prefix="liferay-security" %>
<%@taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>
<%@taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@taglib uri="http://liferay.com/tld/util" prefix="liferay-util" %>

<portlet:defineObjects />
<portlet:actionURL var="getLiveUsers" windowState="normal" name="getLiveUsers">
</portlet:actionURL>
<h2>Portal Users</h2>
<form action="<%=getLiveUsers%>" name="getLiveUsersForm" method="POST">
	<input type="submit" name="GetPortalUsers" id="GetPortalUsers" value="Get Portal Users"/>
</form>

<%
	if(renderRequest.getAttribute("portalUsers")!=null){
%>
<table border="1">
	<tr>
		<th>User Id</th>
		<th>Email Address</th>
		<th>FullName</th>
		<th>User Position</th>
		<th>User Birthday</th>
		<th>Phone Number</th>
		<th>Organization</th>
	</tr>
	<%
		String[] russianMonat =
				{"января", "февраля", "марта", "апреля", "мая", "июня", "июля",
						"августа", "сентября", "октября", "ноября", "декабря"
				};
		DateFormatSymbols russSymbol = new DateFormatSymbols(new Locale("ru", "RU"));
		russSymbol.setMonths(russianMonat);
		SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy года", russSymbol);

		List<User> thatusers = (List<User>) renderRequest.getAttribute("allUsers");
		for (User user1 : thatusers)
		{
			List <Organization> myorg = OrganizationLocalServiceUtil.getUserOrganizations(user1.getUserId());
			List <Phone> myphone = PhoneLocalServiceUtil.getPhones(user1.getCompanyId(), Contact.class.getName(), user1.getContactId());
	%>

	<tr>
		<td><%=user1.getUserId()%></td>
		<td><%=user1.getDisplayEmailAddress()%></td>
		<td><%=user1.getFullName()%></td>
		<td><%=user1.getJobTitle()%></td>
		<td><%=sdf.format(user1.getBirthday())%></td>
		<td><%for (Phone phone : myphone){%>
		<%=phone.getNumber()%>
		<%}%>
		</td>
		<td><%for (Organization org : myorg){%>
		<%=org.getName()%>
		<%}%>
		</td>
	</tr>
	<%}%>
</table>
<%}%>

