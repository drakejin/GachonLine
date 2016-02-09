;
GachonNoty = {

	showCustomNoty : function(paramMsg, paramNotyType, paramLayout) {
		// set default
		if (!paramNotyType) {
			paramNotyType = 'inform';
		}
		if (!paramLayout) {
			paramLayout = 'center';
		}

		noty({
			layout : paramLayout,
			type : paramNotyType,
			text : paramMsg,
			theme: 'bootstrapTheme'
		});
	},

	showConfirmNoty : function(paramMsg, paramCallbackFunc) {
		noty({
			layout : 'center',
			text : paramMsg,
			dismissQueue : true,
			buttons : [ {
				addClass : 'btn btn-primary',
				text : 'Ok',
				onClick : function($noty) {
					$noty.close();
					if (paramCallbackFunc !== undefined && paramCallbackFunc !== "") {
						setTimeout(paramCallbackFunc, 0, true);
					}
				}
			}, {
				addClass : 'btn btn-danger',
				text : 'Cancel',
				onClick : function($noty) {
					$noty.close();
					noty({
						layout : 'center',
						text : 'Cancel',
						type : 'warning',
						theme: 'bootstrapTheme'
					});
				}
			} ]
		});
	},

	showResultNoty : function(paramCode, paramResultMsg) {
		var notyType;
		if (paramCode >= 0) {
			notyType = 'success';
		} else {
			notyType = 'error';
		}
		noty({
			layout : 'center',
			type : notyType,
			text : paramResultMsg,
			theme: 'bootstrapTheme'
		});
	},

	showAjaxErrorNoty : function(request, status, errorThrown) {
		// console.info(request);
		// console.log(status);
		// console.log(errorThrown);
		// 세션이 유효하지 않을때 라고 생각한다만.... 140905 by bestheroz
		if (errorThrown === "Bad Request") {
			// document.location.href = '/gachon/login/login.go?error=잘못된 접근
			// 감지!<br />다시 로그인해주세요!';
		}

		var msg = "ajax error occurred!!!<br>";
		msg += "request.status: " + request.status + "<br>";
		msg += "request.statusText: " + request.statusText;

		noty({
			layout : 'center',
			type : 'error',
			text : msg,
			theme: 'bootstrapTheme'
		});
	}

}