package frontlinesms2.contact

import frontlinesms2.*
import java.text.DateFormat
import java.text.SimpleDateFormat
import java.util.Date

abstract class PageContact extends frontlinesms2.base.PageBase {
	static url = 'contact/'
	static content = {
		bodyMenu { module BodyMenu }
		header { module ContentHeader }
		footer { module ContentFooter }
		contactList { module ContactList }
		singleContactDetails { module SingleContactDetails }
		multipleContactDetails { module MultipleContactDetails }
	}
}

class BodyMenu extends geb.Module {
	static content = {
		selected { $('#body-menu .selected').text().toLowerCase() }
		groupLinks { $('#body-menu li.groups ul.submenu li a') }
		smartGroupLinks { $('#body-menu li.smartgroups ul.submenu li a') }
		newContact { $('#body-menu li.contacts .create a') }
		newGroup { $('#body-menu li.groups .create a') }
		newSmartGroup { $('#body-menu li.smartgroups .create a') }
	}
}

class ContentHeader extends geb.Module {
	static base = { $('#main-list-head') }
	static content = {
		title { $('h1').text().toLowerCase() }
		button { $('a.btn, input[type="button"], button') }
	}
}

class ContentFooter extends geb.Module {
	static base = { $('#main-list-foot') }
	static content = {
		search { $('a')[0] }
		noneSearch { $('#contact-search').text().toLowerCase() == "search" }
		searchDetails { $('#contact-search').text() }
		nextPage { $('a.nextLink') }
		prevPage { $('a.prevLink') }
	}
}

class ContactList extends geb.Module {
	static base = { $('#main-list') }
	static content = {
		sources { $('td.message-sender-cell')*.text() }
		messages { moduleList MessageListRow, $('tr') }
		selectedMessages { moduleList MessageListRow, $('tr.selected') }
		noContent { $('td.no-content') }
	}
}

class SingleContactDetails extends geb.Module {
	static base = { $('#single-contact') }
	static content = {
		name { $('#message-detail-content') }
		mobile { $('#message-detail-sender') }
		email { $('#message-detail-content') }
		notes { $('#notes')}
		addMoreInfomation { customField -> 
			$('select#new-field-dropdown').jquery.val(customField)
			$('select#new-field-dropdown').jquery.trigger("change")
		}
        groupList { $('ul#group-list li')*.@groupname }
		addToGroup { groupName -> 
			$('select#group-dropdown').jquery.val(groupName)
			$('select#group-dropdown').jquery.trigger("change")
		}
		save { $('#action-buttons a', text:'Save') }
		cancel { $('#action-buttons a', text:'Cancel') }
		delete { $('#btn_delete') }
	}
}

class MultipleContactDetails extends geb.Module {
	static base = { $('#multiple-contacts') }
	static content = {
		checkedContactCount { $("h2#checked-contact-count").text().split(" ")[0].toInteger() }
	}
}