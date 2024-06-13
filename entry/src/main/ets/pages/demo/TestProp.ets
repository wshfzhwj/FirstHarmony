@Entry
@Component
struct TestProp {
  @State car: number = 1
  build() {
    Column(){
      Text(`父组件 ${this.car}`)
      BCom({bCar:this.car})
      Button("换一下").onClick(()=>{
        this.car = 3
      })
    }.backgroundColor(Color.Orange)
    .padding(100)
  }
}
@Component
struct BCom {
  @Prop bCar:number
  build() {
    Column(){
      Text(`子组件${this.bCar}`)
    }.backgroundColor(Color.Pink)
    .padding(30)
  }
}