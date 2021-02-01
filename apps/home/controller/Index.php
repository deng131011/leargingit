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
use think\cache\driver\Redis;
use think\Db;

class Index extends Home {

    function _initialize()
    {
        parent::_initialize();

    }
    
    /**
     * 首页
     * @return [type] [description]
     */
    public function miao_sha($uid,$product_id,$buy_num)
    {
        $redis = new \Redis();
        $redis->connect('127.0.0.1', '6379');
        $redis->auth('1234567'); //密码验证



      
       $hh= $redis->rPush('product','dengsong');
       $hh= $redis->rPush('product','xiaojiang');
       $hh= $redis->rPush('product','xiaoming');
       //$hh= $redis->hSet('runob','field3','dengpeng');

        $hh= $redis->lGetRange('product',0,-1);
        p($hh);
        //$redis->set('myname','dengling');
       $rr =  $redis->get('myname');


        p($rr);
        p(1);

       //p($redis->lTrim('product',1,-1));
        $list = $redis->lRange('product',0,-1);
        p($list);
        for($i=1;$i<=10;$i++){
            $redis->rPush('product',$i);
        }

        $product = db('product')->find($product_id);
        if($product['stock']<=0){
            return '秒杀结束';
        }
        //$redis->del('product_'.$product_id);
       //$hh = $redis->Del('user_buy_'.$product_id);


        $user_all = $redis->hGetAll('user_buy_'.$product_id); //当前商品进入队列的用户数量
        $duilie_len = $redis->lLen('product_'.$product_id);
p($duilie_len);
        if(empty($user_all) && empty($duilie_len)){
            for($i=0;$i<$product['stock'];$i++){
                $redis->lPush('product_'.$product_id,1);
            }
        }
        $duilie_len = $redis->lLen('product_'.$product_id);
        if(empty($duilie_len) || $duilie_len<=0){
            return '系统繁忙，稍后再试';
        }
        if($buy_num>$duilie_len){
            return '库存不足';
        }

        $yc_res = $redis->lPop('product_'.$product_id);

        $userinfo = ['uid'=>$uid,'create_time'=>time()];

        $res2 = $redis->hSet('user_buy_'.$product_id,$uid,serialize($userinfo));

        if($yc_res){
            Db::startTrans();
            try{
                $data['order_number'] = time().rand(1000,9999);
                $data['uid'] = $uid;
                $data['create_time'] = time();
                db('order')->insert($data);

                db('product')->where('id',$product_id)->setDec('stock');

                Db::commit();
                return '秒杀成功';
            }catch (\Exception $e){
                Db::rollback();
                return '秒杀失败2';
            }

        }else{
            return '秒杀失败1';
        }

    	return $this->fetch();
    }

    public function details(){

        $get = input('param.');
        $res = $this->miao_sha(1,$get['id'],1);
        p($res);
    }



}