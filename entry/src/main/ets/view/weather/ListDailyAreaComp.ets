@Component
export default struct ListDailyAreaComp {
  @Link city: string

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_extra_m'))
        Text(this.city)
          .fontSize(20)
      }
    }.margin({ top: 10 })
  }
}