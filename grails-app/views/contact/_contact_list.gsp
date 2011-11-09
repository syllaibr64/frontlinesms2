<%@ page contentType="text/html;charset=UTF-8" %>
	<g:if test="${contactInstanceTotal > 0}">
		<ul id="contact-list">
			<g:if test="${!contactInstance ? false : !contactInstance.id}">
				<li class="selected" id="newContact">
					<g:checkBox disabled="disabled" name='new-contact-select' />
					<a disabled="disabled" href="">[New Contact]</a>
				</li>
			</g:if>
			<g:each in="${contactInstanceList}" status="i" var="c">
				<li class="${c.id == contactInstance?.id ? 'selected' : ''}" id="contact-${c.id}">
					<g:checkBox name="contact-select" class="contact-select" id="contact-select-${c.id}"
							checked="${params.checkedId == c.id + '' ? 'true': 'false'}" value="${c.id}" onclick="contactChecked(${c.id});"/>
					<g:if test="${contactsSection instanceof frontlinesms2.Group}">
						<g:link class="contact-name displayName-${c.id}" controller="contact" action="show" params="[contactId:c.id, groupId:contactsSection.id, sort: params.sort, offset: params.offset]">
							${c.name?:c.primaryMobile?:c.secondaryMobile?:'[No Name]'}
						</g:link>
					</g:if>
					<g:else>
						<g:link class="displayName-${c.id} contact-name" action="show" params="[contactId: c.id, sort: params.sort, offset: params.offset]">
							${c.name?:c.primaryMobile?:c.secondaryMobile?:'[No Name]'}
						</g:link>
					</g:else>
				</li>
			</g:each>
		</ul>
	</g:if>
	<g:else>
		<div id="contact-list">
			No contacts here!
		</div>
	</g:else>
