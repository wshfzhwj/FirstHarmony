@Component
export struct UserIndex {
  build() {
    Column(){
      Text('用户页')
    }.width('100%')
    .height('100%')
    .backgroundColor($r('app.color.index_page_background'))
    .justifyContent(FlexAlign.Center)
  }
}