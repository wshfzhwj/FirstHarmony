import { WanBeanItem } from './WanBeanItem';

export class WanBeanList {
  curPage: number = 0;
  size: number = 0;
  total: number = 0;
  pageCount: number = 0;
  datas: Array<WanBeanItem>
}