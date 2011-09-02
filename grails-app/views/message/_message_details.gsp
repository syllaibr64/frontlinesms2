<div id="message-details">
	<g:hiddenField name="checkedMessageList" id="checkedMessageList" value="${checkedMessageList}" />
	<div id="single-message">
		<g:hiddenField id="message-src" name="message-src" value="${messageInstance.src}"/>
		<g:hiddenField id="message-id" name="message-id" value="${messageInstance.id}"/>
		<div id='message-info'>
			<h2 id="contact-name">${messageInstance.contactName}
				<g:if test="${!messageInstance.contactExists}">
					<g:link class="button" id="add-contact" controller="contact" action="createContact" params="[primaryMobile: (messageSection == 'sent' || messageSection == 'pending') ? messageInstance.dst : messageInstance.src]"><img src='${resource(dir: 'images/icons', file: 'messagehistory.gif')}'/></g:link>
				</g:if>
			</h2>
			<p id="message-date"><g:formatDate date="${messageInstance.dateCreated}"/></p>
			<p id="message-body">${messageInstance.text}</p>
		</div>
		<g:render template="../message/message_actions" model="[buttons: buttons]"></g:render>
		<g:render template="../message/other_actions"></g:render>
	</div>
	<div id="multiple-messages">
		<div id='message-info'>
			<h2 id='checked-message-count'>${checkedMessageCount} messages selected</h2>
			<div class="actions">

				<ol class="buttons">
					<g:if test="${multiButtons != null}">
						${multiButtons}
					</g:if>
					<g:else>
						<div id='other_btns'>
							<g:if test="${messageSection != 'pending'}">
								<li class='static_btn'>
									<g:remoteLink elementId="reply-all" controller="quickMessage" action="create" params="[messageSection: messageSection, recipients: params.checkedMessageList, ownerId: ownerInstance?.id, archived: params.archived, configureTabs: 'tabs-1,tabs-3,tabs-4']" onSuccess="launchMediumWizard('Reply All', data, 'Send', null, true);addTabValidations()">
										Reply All
									</g:remoteLink>
								</li>
							</g:if>
							<g:render template="message_button_renderer" model="${[value:'Archive All',id:'btn_archive_all',action:'archiveAll']}"></g:render>
							<g:render template="message_button_renderer" model="${[value:'Delete All',id:'btn_delete_all',action:'deleteAll']}"></g:render>
						</div>
					</g:else>
				</ol>
				<g:render template="../message/other_actions"></g:render>
			</div>
		</div>
	</div>
	
</div>
