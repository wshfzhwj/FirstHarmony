@Component
export default  struct AddressAreaComp {
  @Link city:string
  build() {
    Column(){
      Row(){
        Image($r('app.media.ic_extra_m')).height(30).width(30)
        Text(this.city)
          .fontSize(20)
      }
    }.margin({top:10})
  }
}