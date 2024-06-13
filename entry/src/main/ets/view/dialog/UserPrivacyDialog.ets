@CustomDialog
export default struct UserPrivacyDialog {
  controller: CustomDialogController
  confirm: () => void
  cancel: () => void

  build() {
    Column({ space: 10 }) {
      //标题
      Text($r('app.string.user_privacy_title')).fontSize(20).fontWeight(20)
      //内容
      Text($r('app.string.user_privacy_content'))
      //按钮
      Button('同意').width(150)
        .backgroundColor('#028f56')
        .onClick(() => {
          this.confirm()
          this.controller.close()
        })
      Button('不同意').width(150)
        .backgroundColor('#a25620')
        .onClick(() => {
          this.cancel()
          this.controller.close()
        })
    }
    .width('100%')
    .padding(10)
  }
}

