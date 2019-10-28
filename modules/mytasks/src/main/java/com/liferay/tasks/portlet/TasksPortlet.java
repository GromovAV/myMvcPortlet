package com.liferay.tasks.portlet;

import com.liferay.portal.kernel.dao.orm.QueryUtil;
import com.liferay.portal.kernel.model.User;
import com.liferay.portal.kernel.service.UserLocalService;
import com.liferay.tasks.constants.TasksPortletKeys;

import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;

import javax.portlet.*;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import java.io.IOException;
import java.util.List;

/**
 * @author Антон
 */
@Component(
	immediate = true,
	property = {
		"com.liferay.portlet.display-category= My Liferay project",
		"com.liferay.portlet.header-portlet-css=/css/main.css",
		"com.liferay.portlet.instanceable=true",
		"javax.portlet.display-name=My portlet",
		"javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.view-template=/view.jsp",
		"javax.portlet.name=" + TasksPortletKeys.TASKS,
		"javax.portlet.resource-bundle=content.Language",
		"javax.portlet.security-role-ref=power-user,user"
	},
	service = Portlet.class
)
public class TasksPortlet extends MVCPortlet {

	public void render(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException{
		List<User> users = null;
		try {
			users = _userLocalService.getUsers(QueryUtil.ALL_POS, QueryUtil.ALL_POS);
		} catch (com.liferay.portal.kernel.exception.SystemException e) {
		}
		renderRequest.setAttribute("allUsers", users );
		super.render(renderRequest, renderResponse);
	}

	@Reference
	private volatile UserLocalService _userLocalService;

	@SuppressWarnings("unchecked")
    @ProcessAction(name="getLiveUsers")
	public void getLiveUsers(ActionRequest actionRequest,
							 ActionResponse actionResponse) throws IOException, PortletException {
		try{
			List<User> users = null;
			users = _userLocalService.getUsers(QueryUtil.ALL_POS, QueryUtil.ALL_POS);
			actionRequest.setAttribute("portalUsers", users);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}