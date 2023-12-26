import { WanListBean } from './WanListBean';

export class WanBean {
  curPage: number = 0;
  size: number = 0;
  total: number = 0;
  pageCount: number = 0;
  datas: Array<WanListBean>
}