<?php
// +----------------------------------------------------------------------
// | Copyright (c) 2016-2018 https://www.eacoophp.com, All rights reserved.         
// +----------------------------------------------------------------------
// | [EacooPHP] 并不是自由软件,可免费使用,未经许可不能去掉EacooPHP相关版权。
// | 禁止在EacooPHP整体或任何部分基础上发展任何派生、修改或第三方版本用于重新分发
// +----------------------------------------------------------------------
// | Author:  心云间、凝听 <981248356@qq.com>
// +----------------------------------------------------------------------
namespace app\home\controller;
use app\common\model\User as UserModel;
use think\captcha\Captcha;

class Login extends Home {



    public function _initialize(){
        parent::_initialize();
        $goods_id = I("goods_id",'0','intval');
        if($goods_id){
            $this->goods_id = $goods_id;
            $this->user_queue_key = "goods_".$goods_id."_user";//当前商品队列的用户情况
            $this->goods_number_key = "goods".$goods_id;//当前商品的库存队列
        }
        $this->user_id = $this->user_id ? $this->user_id : $_SESSION['uid'];
    }


    /**
     * 访问产品前先将当前产品库存队列
     */
    public function _before_detail(){
        $where['goods_id'] = $this->goods_id;
        $where['start_time'] = array("lt",time());
        $where['end_time'] =  array("gt",time());
        $goods = M("goods")->where($where)->field('goods_num,start_time,end_time')->find();
        if(empty($goods)){
             $this->error("当前秒杀已结束！");
        }
        if($goods['goods_num'] > $goods['order_num']){
            $redis = $this->connectRedis();
            $getUserRedis = $redis->hGetAll("{$this->user_queue_key}");
            $gnRedis = $redis->llen("{$this->goods_number_key}");
            /* 如果没有会员进来队列库存 */
            if(!count($getUserRedis) && !$gnRedis){
                for ($i = 0; $i < $goods['goods_num']; $i ++) {
                    $redis->lpush("{$this->goods_number_key}", 1);
                }
            }
            $resetRedis = $redis->llen("{$this->goods_number_key}");
            if(!$resetRedis){
                $this->error("系统繁忙，请稍后抢购！");
            }
        }else{
            $this->error("当前产品已经秒杀完！");
        }

    }


    /**
     * 抢购商品前处理当前会员是否进入队列
     */
    public function goods_number_queue(){
        if(!$this->user_id){
            $this->ajaxReturn(array("status" => "-1","msg" => "请先登录"));
        }

        $where['goods_id'] = $this->goods_id;
        $goods_info = M("flash_sale")->where($where)->find();
        !$goods_info && $this->error("对不起当前商品不存在或已下架！");
        /* redis 队列 */
        $redis = $this->connectRedis();
        /* 进入队列  */
        $goods_number_key = $redis->llen("{$this->goods_number_key}");
        if (!$redis->hGet("{$this->user_queue_key}", $this->user_id)) {
            $goods_number_key = $redis->lpop("{$this->goods_number_key}");
        }

        if($goods_number_key){
            // 判断用户是否已在队列
            if (!$redis->hGet("{$this->user_queue_key}", $this->user_id)) {
                // 插入抢购用户信息
                $userinfo = array(
                    "user_id" => $this->user_id,
                    "create_time" => time()
                );
                $redis->hSet("{$this->user_queue_key}", $this->user_id, serialize($userinfo));
                $this->ajaxReturn(array("status" => "1"));
            }else{
                $modelCart = M("cart");
                $condition['user_id'] = $this->user_id;
                $condition['goods_id'] = $this->goods_id;
                $condition['prom_type'] = 1;
                $cartlist = $modelCart->where($condition)->count();
                if($cartlist > 0){
                    $this->ajaxReturn(array("status" => "2"));
                }else{

                    $this->ajaxReturn(array("status" => "1"));

                }

            }

        }else{
            $this->ajaxReturn(array("status" => "-1","msg" => "系统繁忙,请重试！"));
        }
    }


}