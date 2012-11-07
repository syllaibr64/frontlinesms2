<r:script>
	function initializePopup() {
		<g:if test="${activityInstanceToEdit?.id}">
			$("#messageText").val("${activityInstanceToEdit.sentMessageText}");
			$("#messageText").trigger("keyup");
			checkSavedContactsAndGroups();
		</g:if>

		aliasCustomValidation();
		genericSortingValidation();

		var validator = $("#create_autoforward").validate({
			errorContainer: ".error-panel",
			rules: {
				messageText: { required:true },
				name: { required:true }
			}
		});

		var keyWordTabValidation = function() {
			if(!isGroupChecked("blankKeyword")){
				return validator.element('#keywords');
			}
			 else return true;
		};
		var messageTextTabValidation = function() {
			return validator.element('#messageText');
		};

		var recipientTabValidation = function() {
			var valid = false;
			addAddressHandler();
			valid = $('input[name=addresses]:checked').length > 0;
			return valid;
		};

		var confirmTabValidation = function() {
			return validator.element('input[name=name]');
		};

		mediumPopup.addValidation('activity-generic-sorting', keyWordTabValidation);
		mediumPopup.addValidation('autoforward-create-message', messageTextTabValidation);
		mediumPopup.addValidation('autoforward-recipients', recipientTabValidation);
		mediumPopup.addValidation('autoforward-confirm', confirmTabValidation);

		$("#tabs").bind("tabsshow", function(event, ui) {
			updateConfirmationMessage();
		});
	}

	function updateConfirmationMessage() {
		var autoforwardText = $('#messageText').val().htmlEncode();
		if(!(isGroupChecked("blankKeyword"))){
			var keywords = $('#keywords').val().toUpperCase();
			$("#keyword-confirm").html('<p>' + keywords  + '</p>');
		} else {
			$("#keyword-confirm").html('<p>' + i18n("autoforward.blank.keyword")  + '</p>');
		}
		$("#autoforward-confirm").html('<p>' + autoforwardText  + '</p>');
	}
	
	function checkSavedContactsAndGroups(){
		<g:each in="${activityInstanceToEdit?.contacts}" var="c">
			$("#recipients-list input[value='${c.mobile}']").trigger("click");
		</g:each>
		<g:each in="${activityInstanceToEdit?.groups}" var="g">
			$("#recipients-list input[value='group-${g.id}']").trigger("click");
		</g:each>
		<g:each in="${activityInstanceToEdit?.smartGroups}" var="g">
			$("#recipients-list input[value='smartgroup-${g.id}']").trigger("click");
		</g:each>
	}

</r:script>
