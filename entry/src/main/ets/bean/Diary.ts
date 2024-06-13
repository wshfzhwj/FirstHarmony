export class Diary {
  date: string
  title: string
  weather: string
  content: string

  constructor(date: string, title: string, weather: string, content: string) {
    this.date = date;
    this.title = title;
    this.weather = weather;
    this.content = content;
  }

  getDate() {
    return this.date
  }

  getTitle() {
    return this.title
  }

  getWeather() {
    return this.weather
  }

  getContent() {
    return this.content
  }

  toJSONString(): string {
    return JSON.stringify(this)
  }
}