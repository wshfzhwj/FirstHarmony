@Component
export default struct NowAreaComp {
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