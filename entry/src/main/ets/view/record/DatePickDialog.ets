import { CommonConstants } from '../../constants/CommonConstants'

@CustomDialog
export default struct DatePickDialog {
  controller: CustomDialogController
  selectedDate: Date = new Date()

  build() {
    Column({ space: CommonConstants.SPACE_12 }) {
      //日期
      DatePicker({
        start: new Date('2020-01-01'),
        end: new Date('2024-06-02'),
        selected: this.selectedDate
      })
        .onDateChange((value: Date) => {
          this.selectedDate.setFullYear(value.getFullYear()!, value.getMonth(), value.getDay())
        })
      //按钮
      Row({ space: CommonConstants.SPACE_12 }) {
        Button('取消')
          .width(120)
          .backgroundColor($r('app.color.light_gray'))
          .onClick(() => {
            this.controller.close()
          })
        Button('确定')
          .width(120)
          .backgroundColor($r('app.color.primary_color'))
          .onClick(() => {
            //保存日期到全局
            AppStorage.setOrCreate('selectedDate', this.selectedDate.getTime())
            //关闭窗口
            this.controller.close()
          })
      }
    }
    .padding(CommonConstants.SPACE_12)
  }
}