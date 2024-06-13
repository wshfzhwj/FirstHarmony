@Component
export default struct ListDailyItemComp {
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