// Comp2.ets

import router from '@ohos.router'
// 通过getShared接口获取stage共享的LocalStorage实例
let storage = LocalStorage.GetShared()
@Entry(storage)
@Component
struct LocalStorageSharedIndex2 {
  @State message:string = 'Comp2'
  @LocalStorageLink('cityName') cityName:string = ''

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
        Button('返回Comp1')
          .onClick(()=>{
            this.cityName = '深圳'
            router.back()
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}