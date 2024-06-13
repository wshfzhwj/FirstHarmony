import reminderAgentManager from '@ohos.reminderAgentManager'
let timer : reminderAgentManager.ReminderRequestTimer = {
  reminderType:reminderAgentManager.ReminderType.REMINDER_TYPE_TIMER,
  triggerTimeInSeconds:30,
  actionButton:[
    {
      title:'关闭',
      type:reminderAgentManager.ActionButtonType.ACTION_BUTTON_TYPE_CLOSE
    }
  ],
  title:'我的标题',
  content:'这里是通知的内容，可以自行定义',
  expiredContent:'更多',
  notificationId:100
}

export function  pubReminder(){
  reminderAgentManager.publishReminder(timer,(err,reminderId)=>{
    console.log(JSON.stringify(err))
    console.log('reminderId : ' + reminderId)
  })
}