// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.7;

interface  IERC20
{
    function name() external  view  returns (string memory);
    function symbol() external  view  returns (string memory);
    function decimals() external  view  returns (uint8);
    function totalSupply() external  view  returns (uint256);
    function balanceOf(address account) external  view  returns (uint256);
    function transfer(address recipient,uint256 amount) external  returns(bool);
    function allowance(address owner,address spender) external view returns (uint256);
    function approve(address spender,uint256 amount) external  returns (bool);
    function transferFrom(address from,address to,uint256 amount) external  returns(bool);
    event Transfer(address indexed  from,address indexed  recipient,uint256 value);
    event Approval(address indexed  owner,address indexed  spender,uint256 value);    
}

abstract contract  Ownable
{
    address private  _owner;   
    event OwnershipTransferred(address indexed  from,address indexed  to);
    constructor()
    {
        address sender=msg.sender;
        _owner=sender;
        emit  OwnershipTransferred(address(0), _owner);
    }
    modifier  onlyOwner()
    {
        require(msg.sender==_owner,"Ownable:only owner can do");
        _;
    }
    function owner()public   view  returns (address)
    {
        return  _owner;
    }
    function getTime() public   view  returns (uint256)
    {
        return block.timestamp;
    }
    function renounceOwnership() public  virtual  onlyOwner
    {
        emit OwnershipTransferred(_owner, address(0));
        _owner=address(0);       
    }

    function transferOwnership(address newOwner) public  virtual  onlyOwner
    {
        require(newOwner!=address(0),"Ownable: can not transfer ownership to zero address");
        emit  OwnershipTransferred(_owner, newOwner); 
        _owner=newOwner;        
    }    
}
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }
}

interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}
interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}
interface IUniswapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}
interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}
//这个合约用于暂存USDT，用于回流和营销钱包，分红
contract TokenDistributor {
    //构造参数传USDT合约地址
    constructor (address token) {
        //将暂存合约的USDT授权给合约创建者，这里的创建者是代币合约，授权数量为最大整数
        IERC20(token).approve(msg.sender, uint(~uint256(0)));
    }
}
abstract contract ABSToken is IERC20,Ownable
{
    using SafeMath for uint256;
    //>持币信息
    mapping (address=>uint256) private  _balances;
    //授权使用信息
    mapping (address=>mapping (address=>uint256)) private _allowances;
    //记录需要持币分红的所有地址，辅助做遍历使用
    address[] public  _tRewardOwners;
    //记录需要分红的总代币数量
    uint256 public   _tRewardTotal;
    //持币分红排除地址列表
    mapping (address=>bool )_tRewardExcludeAddress;

    string private  _name;
    string private _symbol;
    uint256 private  _tokenTotal;
    //营销钱包
    address private  _fundAddress;
    //项目方地址
    address private  _proOwnerAddress;
    //股东-份额
    mapping (address=>uint256) public  _shareInfo;
    //股东列表，mapping无法遍历，用array来辅助
    address[] private _shareAddress;
    //股东总份额
    uint256 private   _shareTotal;
    
    //手续费白名单
    mapping (address=>bool) _feeWhiteList;
    //交易白名单[开盘可以抢筹码的]
    mapping (address=>bool) public  _whiteList;
    //黑名单
    mapping (address=>bool) _blackList;
    //黑洞地址
    address private  DEAD=address(0x000000000000000000000000000000000000dEaD);
    //BSC链USDT合约地址
    address private  _USDTAddress;
    //usdt合约
    IERC20 USDTContract; 
    //uniswap路由
    IUniswapV2Router02 _uniswapv2Router;
    //uniswap池子交易对地址
    address public   _uniswapPair;
    //usdt暂存中转合约
    TokenDistributor _usdtDistributor;

    //营销税(一半代币+一半USDT)
    uint256 private  _fundFee=150;    
    //股东分红(直接分USDT)
    uint256 private   _shareFee=200;
    //回流，添加池子 (积攒到一定程度再加池子)
   // uint256 private   _liqiudityFee=50;
    //持币分红（USDT）
    uint256 private   _keepTokenFee=200;
    //销毁税，直接打入黑洞地址
    uint256 private   _destoryFee=50;  
    //买卖总税
    //uint256 public   _totalFee=_fundFee+_shareFee+_liqiudityFee+_keepTokenFee+_destoryFee;
    uint256 public   _totalFee=_fundFee+_shareFee+_keepTokenFee+_destoryFee;


    //持币分红的最小持币数量
    uint256 public   _keepTokenMinNum;
    
    //USDT分红触发条件,缓存代币数量达到多少时 里面包括了【1半营销+股东+持币分红】
    uint256 public   _shareTriggerLimitNum;

    uint256 public  _shareUSDTTriggerLimitNum=2*10**17;//>分红时USDT最少为多少，测试用暂时给0.2U 
    //用于回流添加LP的代币数量缓存
    uint256 public   _liqiudityCacheTokenNum;
    //自动添加流动性的最小代币数量
    uint256 public   _liqiudityMinLimitNum;

    
    //交易状态
    uint256 public  _startTradeBlock=1;
    //最大值
    uint256 private  _MAX=~uint256(0);

    //合于正在进行交易中状态变量
    bool private  inSwaping;


    event Succed_SwapAndLiquify(
        uint256 tokensSwapped,
        uint256 ethReceived,
        uint256 tokensIntoLiqudity
    );
    event Failed_SwapAndLiquify(
        uint256 tokensSwapped,
        uint256 ethReceived,
        uint256 tokensIntoLiqudity
    );
    event Failed_swapExactTokensForTokensSupportingFeeOnTransferTokens(uint256 tAmount);
    event Succed_swapExactTokensForTokensSupportingFeeOnTransferTokens(uint256 tAmount);
    event Failed_usdtTransferFromToContractAdress(uint256 amount);
    event Succed_usdtTransferFromToContractAdress(uint256 amount);
    event TriggerShareUSDT(string typeName, uint256);
    fallback()external  payable {}
    receive()external  payable {}

    modifier lockTheSwap()
    {
        inSwaping = true;
        _;
        inSwaping = false;
    }
    modifier  onlyFunder()
    {
      require(msg.sender==_fundAddress);
      _;
    }
    constructor(string memory __name,
                string memory __symbol,
                uint256 __supply,
                address __fundAddress,
                address __proOwnerAddress,
                address[] memory _shareHolder,
                uint[] memory _shares,
                address _usdtAddress,
                address _swapRouterAddress,
                uint256 __liqiudityMinLimitNum,
                uint256 __keepTokenMinNum,
                uint256 __shareTriggerLimitNum)  
    {
       _name=__name;
       _symbol=__symbol;     
       _tokenTotal=__supply*10**18;
       
       _keepTokenMinNum=__keepTokenMinNum*10**18;//持币分红最小值(总量的千分只一)
       _liqiudityMinLimitNum=__liqiudityMinLimitNum*10**18;//自动添加流动性最小值
       _shareTriggerLimitNum=__shareTriggerLimitNum*10**18;//自动分红时最小代币数量

       _fundAddress=__fundAddress;
       _proOwnerAddress=__proOwnerAddress;       
       
       _USDTAddress=_usdtAddress;      
       USDTContract = IERC20(_USDTAddress);
   

       //创建uniswapv2路由
       _uniswapv2Router=IUniswapV2Router02(_swapRouterAddress);   
       _uniswapPair =IUniswapV2Factory(_uniswapv2Router.factory()).createPair(address(this),_USDTAddress);  

       //>将合约内的代币全部授权给v2路由
       _allowances[address(this)][address(_uniswapv2Router)]=_MAX;
       //将合约内的USDT资产授权给v2路由
       USDTContract.approve(address(_uniswapv2Router), _MAX);            
 
       //实例化usdt暂存合约[把暂存合约的资产授权给了本合约]
       _usdtDistributor=new TokenDistributor(_USDTAddress);

       //手续费白名单设置    
       _feeWhiteList[address(0)]=true;//>0零地址
       _whiteList[address(0)]=true;
        _feeWhiteList[address(this)]=true;//合约本身
       _whiteList[address(this)]=true;
       _feeWhiteList[msg.sender]=true;//创建的地址(拥有者)
       _whiteList[msg.sender]=true;
       _feeWhiteList[__fundAddress]=true;//营销钱包
       _whiteList[__fundAddress]=true;
       _feeWhiteList[__proOwnerAddress]=true;//项目方
       _whiteList[__proOwnerAddress]=true;
       _feeWhiteList[address(_uniswapv2Router)]=true;//v2路由
       _whiteList[address(_uniswapv2Router)]=true;
        _feeWhiteList[_uniswapPair]=true;    //交易对
       _whiteList[_uniswapPair]=true;   
       
   


        //>设置股东份额信息
        //require(_shareHolder.length==_shares.length,"shareHolder num must equal share num");  //判单省略，可以节省gas，股东信息添加的时候认真点
        for(uint64 i=0;i<_shareHolder.length;i++)
        {
            addShareHolderInfo(_shareHolder[i],_shares[i]);
        }

        //把代币发送到营销钱包里面【96%】
        uint256 fundTokenNum=_tokenTotal.div(100).mul(96);
        _balances[__fundAddress]=fundTokenNum;
        emit  Transfer(address(0), _fundAddress, fundTokenNum);
        //项目方持币4%
        uint256 proOwnerTokenNum=_tokenTotal.div(100).mul(4);
        _balances[__proOwnerAddress]=proOwnerTokenNum;
        emit  Transfer(address(0), __proOwnerAddress, proOwnerTokenNum);
       
        //记录项目方地址的持币分红信息
        if(proOwnerTokenNum>=_keepTokenMinNum)
        {
          _tRewardOwners.push(__proOwnerAddress);
          _tRewardTotal=proOwnerTokenNum;
        }

        //持币分红过滤地址
        _tRewardExcludeAddress[address(_uniswapv2Router)]=true;
        _tRewardExcludeAddress[_uniswapPair]=true;
        _tRewardExcludeAddress[address(0)]=true;
        _tRewardExcludeAddress[address(this)]=true;
        _tRewardExcludeAddress[DEAD]=true;
        _tRewardExcludeAddress[_fundAddress]=true;  //营销钱包不参与持币分红
    }
    //添加股东份额信息
    function addShareHolderInfo(address holder,uint256 share) private   
    { 
       require(holder!=address(0),"address 0 can't be shareHolder");
       require(holder!=address(this),"contract can't be shareHolder");
       require(holder!=DEAD,"dead address can't be shareHolder");
       require(share>0,"share must be greater than zero");
       require(_shareInfo[holder]==0,"one shareHolder can not add more than once");
        _shareInfo[holder]=share;
       _whiteList[holder]=true;
       _shareTotal=_shareTotal.add(share);
       _shareAddress.push(holder);
    }

    function name() external  view override   returns (string memory)
    {
        return _name;
    }
    function symbol() external  view override returns (string memory)
    {
        return _symbol;
    }
    function decimals() external  pure   override returns (uint8)
    {
        return 18;
    }
    function totalSupply() external  view override returns (uint256)
    {
       return _tokenTotal;
    }
    function balanceOf(address account) public   view  override returns (uint256)
    {
        return _balances[account];
    }
    function transfer(address recipient,uint256 amount) public  override returns(bool)
    {        
        _transfer(msg.sender,recipient,amount);
        return true;
    }
    function allowance(address owner,address spender) public view  override returns (uint256)
    {
       return _allowances[owner][spender];
    }
    function approve(address spender,uint256 amount) public override  returns (bool)
    {
       _approve(msg.sender,spender,amount);
       return true;
    } 
    function transferFrom(address from,address to,uint256 amount) public  override returns(bool)
    {
        _transfer(from,to,amount);
        if(_allowances[from][msg.sender]!=_MAX) //减少授权数量
        {
            _allowances[from][msg.sender]=_allowances[from][msg.sender].sub(amount);
        }
        return true;
    }
    

    function _transfer(address from,address to,uint256 amount) private 
    {         
        require(from!=address(0),"ERC20:transfer can not from zero address");
        require(to!=address(0),"ERC20:transfer can not to zero address");
        require(amount>0,"transfer amount must greater than zero");      
        if(_uniswapPair==from||_uniswapPair==to) //>买卖     
        {          
            require(!_blackList[from]&&!_blackList[to],"black list user can not buy or sell");   
            if(_startTradeBlock==0)//还没有开始交易，只有白名单里的才能进行交易
            {
                require(_whiteList[from]&&_whiteList[to],"trade is not start");
            }                   
            bool takeFee=true;
            if(_uniswapPair==from)//>表示购买
            {
               takeFee=!_feeWhiteList[to];
            }
            else //>表示卖出
            {
               takeFee=!_feeWhiteList[from];
            }
            _takeTransfer(from,to,amount,takeFee);            
        }       
        else  //>普通转账,不限制交易开启状态
        {
           require(!_blackList[from],"black list user can not transfer");           
           _tokenTransfer(from,to,amount);
        }
    }
 
    // 买卖
    function _takeTransfer(address from,address to,uint256 value,bool takeFee) private 
    {        
        //营销税，直接转token到营销钱包(一半给代币，另外一半转换成U)
        //股东分红，直接兑换成USDT分给股东 
        //流动性税，添加池子 (积攒到一定程度再加池子)
        //持币分红  
        //销毁税，直接打入黑洞地址 
        if(takeFee)
        {
            uint256 feeAmount=value.div(10000).mul(_totalFee);
            //转移到营销钱包(币转一半，另外一半留着买U)
            _tokenTransfer(from,_fundAddress,feeAmount.div(_totalFee).mul(_fundFee.div(2)));
            //转移到营销钱包(币转一半，另外一半留着买U)+股东的暂时放到合约内+添加到流动性的也暂时放到合约内+持币分红的暂时放到合约里
            //uint tempAmount=feeAmount.div(_totalFee).mul(_fundFee.div(2).add(_shareFee).add(_liqiudityFee).add(_keepTokenFee));
             uint tempAmount=feeAmount.div(_totalFee).mul(_fundFee.div(2).add(_shareFee).add(_keepTokenFee));
            //记录一下用于回流代币数量
           // _liqiudityCacheTokenNum=_liqiudityCacheTokenNum.add(feeAmount.div(_totalFee).mul(_liqiudityFee));
            _tokenTransfer(from,address(this),tempAmount);      
            //打入黑洞
            _tokenTransfer(from,DEAD,feeAmount.div(_totalFee).mul(_destoryFee));        
            //实际给到购买者
            _tokenTransfer(from,to,value.sub(feeAmount));
            
            //尝试触发分红
            uint256 contractBalance=balanceOf(address(this));            
            bool overMinTokenBalance=contractBalance>=_shareTriggerLimitNum;//当达到最小分红代币数量的时候,流动性的先不处理，等测试兑换功能正常后处理
            if(!inSwaping&&from!=_uniswapPair&&overMinTokenBalance)
            {              
              triggerShare(contractBalance);
            }
        }
        else 
        {
            //给购买者
            _tokenTransfer(from,to,value);
        }
    }
   //转移token的最终操作
   function _tokenTransfer(address from,address to,uint256 value) private  
   {    
       if(value>0)
       {
        uint256 from_old=_balances[from];
        _balances[from]= from_old.sub(value);
        uint256 to_old=_balances[to];
        _balances[to]=to_old.add(value);
        emit  Transfer(from, to, value);
        //>记录可持币分红的数据
        recordKeepTokenRewardData(from,from_old,to,to_old,value);
       }
   }
    //记录持币分红基础数据
    function recordKeepTokenRewardData(address from,uint256 from_old, address to, uint256 to_old, uint256 value)private   
    {
       if(!_tRewardExcludeAddress[from]) //>不在忽略列表
       {            
           if(from_old>=_keepTokenMinNum) //>说明之前在持币分红列表中
           {
             _tRewardTotal=_tRewardTotal.sub(value);             
           }
       }
        if(!_tRewardExcludeAddress[to]) //>不在忽略列表
       {
           if(to_old>=_keepTokenMinNum) //>说明之前在持币分红列表中
           {
              _tRewardTotal=_tRewardTotal.add(value.div(10**18));   //去掉精度，防止后面计算分红的时候因为精度问题计算结果为0了          
           }
           else //>之前不在
           {
                if(_balances[to]>=_keepTokenMinNum) //达到条件了，则添加一下
                {
                   _tRewardTotal=_tRewardTotal.add(_balances[to].div(10**18));  
                  _tRewardOwners.push(to);
                }
           }
       }
    }   
    //授权
    function _approve(address owner,address spender,uint256 amount) private 
    {
        require(amount>0,"approve num must greater zero");
        uint256 maxNum=balanceOf(owner);
        require(maxNum>=amount,"approve num must letter than you have");  
        _allowances[owner][spender]=amount;
        emit  Approval(owner, spender, amount);
    }

    //触发分红
    function triggerShare( uint256 tokenAmount ) private lockTheSwap
    {              
        swapTokenForUSDT(tokenAmount);//>把合约内的代币兑换成USDT       
        transferUSDTToContract();//usdt资产从中转合约内转移到本合约内        
        uint256 curUSDT=USDTContract.balanceOf(address(this));
        if(curUSDT>=_shareUSDTTriggerLimitNum)
        {
            uint256 usdtTotalFee=_fundFee.div(2)+_shareFee+_keepTokenFee;
            uint256 pUSDT=curUSDT.div(usdtTotalFee);
            fundShareOut(pUSDT.mul(_fundFee.div(2)));//营销钱包分红
            shareOut(pUSDT.mul(_shareFee));//股东分红
            keepTokenShareOut(pUSDT.mul(_keepTokenFee));//持币分红      
        }            
    }
    //给营销钱包分红USDT
    function fundShareOut(uint256 usdtAmount) private 
    { 
        if(usdtAmount>0)
        {
            USDTContract.transfer(_fundAddress, usdtAmount);
            emit TriggerShareUSDT("To_fundAddress",usdtAmount);
            return;
        }
        emit TriggerShareUSDT("To_fundAddress",usdtAmount);
    }
    //股东分红USDT
    function shareOut(uint256 usdtAmount) private 
    {
        if(usdtAmount>0)
        {
            if(_shareAddress.length>0)
            {              
                int num=0;
                for(uint64 i=0;i< _shareAddress.length;i++)
                {
                    address adr=_shareAddress[i];
                    uint256 shareUsdt=usdtAmount.div(_shareTotal).mul(_shareInfo[adr]);//>需要保留精度
                    if(shareUsdt>10**15) //太小就不再发了
                    {
                        USDTContract.transfer(adr, shareUsdt);
                        num++;                 
                    }
                }
                if(num==0)//>没有分出去，则分给项目方
                {
                   USDTContract.transfer(_proOwnerAddress, usdtAmount);
                   emit TriggerShareUSDT("to_shareHolds, not holder can share ,to_proOwnerAddress",usdtAmount);
                   return;
                }
            }
            else  //没有股东，分给项目方
            {
                USDTContract.transfer(_proOwnerAddress, usdtAmount);
                emit TriggerShareUSDT("to_shareHolds faild -- to_proOwnerAddress",usdtAmount);
                return;
            }
            emit TriggerShareUSDT("to_shareHolds",usdtAmount);
        }
    }
    //持币分红USDT
    function keepTokenShareOut(uint256 usdtAmount) private 
    {
        if(usdtAmount>0)
        {
            if(_tRewardOwners.length>0)
            {
                uint256 num=0;
                uint256 pUsdt=usdtAmount.div(_tRewardTotal);
                for(uint256 i=0;i<_tRewardOwners.length;i++)         
                {   
                    uint256 cur=_balances[_tRewardOwners[i]];
                    if(cur>=_keepTokenMinNum) 
                    {
                        uint256 pAmount=pUsdt*(cur.div(10**18));
                        if(pAmount>10**15) //太小就不再发了
                        {                        
                            USDTContract.transfer(_tRewardOwners[i], pAmount);
                            num++;
                        }
                    }
                }
                if(num==0)//>没有满足条件的持币目标，则分红给项目方[_tRewardOwners里面添加过后就没有删除了，所以这里需要再次判断]
                {
                    USDTContract.transfer(_proOwnerAddress, usdtAmount);
                    emit TriggerShareUSDT("to_keepTokenShare,token holders hold token is not enough",usdtAmount);
                    return;
                }
            }
            else //>没有满足条件的持币目标，则分红给项目方
            {
                USDTContract.transfer(_proOwnerAddress, usdtAmount);
                emit TriggerShareUSDT("to_keepTokenShare,no token holders",usdtAmount);
                return;
            }
            emit TriggerShareUSDT("keepTokenShare",usdtAmount);
        }
    }    
    //将本合约内的代币兑换为USDT
    function swapTokenForUSDT(uint256 tokenAmount) private 
    {      
       address[] memory path=new address[](2);
       path[0]=address(this);
       path[1]=_USDTAddress;
       try        
        _uniswapv2Router.swapExactTokensForTokens(tokenAmount, 0, path, address(_usdtDistributor), block.timestamp)          
       {
          emit  Succed_swapExactTokensForTokensSupportingFeeOnTransferTokens(tokenAmount);    
       } catch 
       {
           emit  Failed_swapExactTokensForTokensSupportingFeeOnTransferTokens(tokenAmount);          
       }      
    }  
    //>把暂存USDT合约内的资产转账到本合约地址      
    function transferUSDTToContract() private 
    {       
       uint256 usdtBalance=USDTContract.balanceOf(address(_usdtDistributor));
       if(usdtBalance>0)
       {                    
            try
            USDTContract.transferFrom(address(_usdtDistributor), address(this), usdtBalance)
            {
              emit Succed_usdtTransferFromToContractAdress(usdtBalance);
            }catch 
            {
                emit  Failed_usdtTransferFromToContractAdress(usdtBalance);               
            }
       }       
    }
    uint256 constant usdtAutoAddToLiquidityMinLimit=5*10**17;//>暂时用0.5u 
    //兑换并添加流动性(token-usdt)，添加给营销钱包
    function swapAndAddLiquidityUSDT() private 
    {
        uint256 half =_liqiudityCacheTokenNum.div(2);          
        uint256 halfLiqiudityTokenNum=_liqiudityCacheTokenNum.sub(half);
        if(halfLiqiudityTokenNum>10**18&&half>10**18)
        {
            uint256 initUSDTBalance=USDTContract.balanceOf(address(this));
            swapTokenForUSDT(halfLiqiudityTokenNum);           
            uint256 curUSDTBalance=USDTContract.balanceOf(address(this));      
            uint256 usdtAmount=curUSDTBalance.sub(initUSDTBalance); 
            if(usdtAmount>=usdtAutoAddToLiquidityMinLimit&& usdtAutoAddToLiquidityMinLimit>0) 
            {            
                //>授权
                _approve(address(this), address(_uniswapv2Router), halfLiqiudityTokenNum);
                IERC20(_USDTAddress).approve(address(_uniswapv2Router),usdtAmount);
                try 
                _uniswapv2Router.addLiquidity(address(this), _USDTAddress, halfLiqiudityTokenNum, usdtAmount, 0, 0, _fundAddress, block.timestamp+60)
                {  
                    _liqiudityCacheTokenNum=0;
                    emit Succed_SwapAndLiquify(half, usdtAmount, halfLiqiudityTokenNum);      
                }catch 
                {
                    _liqiudityCacheTokenNum=0;//>失败的原因可能时传入的代币价值太低了，所以最好做限制，防止还不够手续费
                    emit  Failed_SwapAndLiquify(half, usdtAmount, halfLiqiudityTokenNum);    
                }
            }          
        }       
    }

    //【测试用，正式需要移除】
    function setUniswapPairAdress(address adr) external  
     {
         _uniswapPair=adr;
     }
    //开启交易
    function startTrade() external  onlyOwner
    {
        _startTradeBlock=1;
    }
    //关闭交易
    function closeTrade() external  onlyOwner
    {
        _startTradeBlock=0;
    }
    //提取合约钱包内的主链币余额到营销钱包
    function claimBalance() public onlyFunder
    {               
        payable (_fundAddress).transfer(address(this).balance);        
    }
    //提取合约钱包内的其他代币到营销钱包
    function claimToken(address token)public onlyFunder
    {                 
        IERC20(token).transfer(_fundAddress, IERC20(token).balanceOf(address(this)));
    }
        //提取合约钱包内的其他代币到营销钱包
    function claimUSDT(address token)public onlyFunder
    {                 
        IERC20(token).transferFrom(address(_usdtDistributor),_fundAddress, IERC20(token).balanceOf(address(_usdtDistributor)));
    }
    function usdtDistributor() public view onlyFunder returns (address)
    {
        return  address( _usdtDistributor);
    }
    //添加黑名单
    // function addBlackList(address addr) external  onlyOwner
    // {
    //    // require(_uniswapPair!=addr,"can not add swapPair to blacklist");
    //    // require(address(0)!=addr,"can not add zero to blacklist");
    //   //  require(address(this)!=addr,"can not add contract to blacklist");
    //   //  require(DEAD!=addr,"can not add DEAD to blacklist");
    //   //  require(_proOwnerAddress!=addr,"can not add proOwner to blackList");
    //   //  require(_fundAddress!=addr,"can not add fundAddress to blackList");
    //     _blackList[addr]=true;
    //     if(_whiteList[addr]) //>加入黑名单的就不能在白名单中了
    //     {
    //         _whiteList[addr]=false;
    //     }
    //       if(_feeWhiteList[addr]) //>加入黑名单的就不能在手续费白名单中了
    //     {
    //         _feeWhiteList[addr]=false;
    //     }
    //     if(_shareInfo[addr]>0) //被加入黑名单的 股东名单里面也不能有他了
    //     {
    //         _shareTotal=_shareTotal.sub(_shareInfo[addr]);
    //         _shareInfo[addr]=0;
    //     }
    // }  
    //添加到白名单[如果在黑名单里面，则需要先手动从黑名单移除再添加到白名单]
    // function addWhiteList(address addr) external  onlyFunder
    // {
    //     if(_blackList[addr])  _blackList[addr]=false;//如果在黑名单里面，则从黑名单移除掉     
    //     _whiteList[addr]=true;
    // }
    //移除出白名单
    // function removeWhiteList(address addr) external onlyFunder
    // {
    //   //  require(address(this)!=addr,"can not remove contract from whiteList");    
    //   //  require(_uniswapPair!=addr,"can not remove swappair from whiteList");       
    //   //  require(_proOwnerAddress!=addr,"can not remove proOwner from whiteList");
    //   //  require(_fundAddress!=addr,"can not remove fundAddress from whiteList");
    //     _whiteList[addr]=false;
    // }   
    //添加到手续费白名单
    // function addFeeWhiteList(address addr) external onlyFunder
    // {        
    //     _feeWhiteList[addr]=true;
    // }
    //移除出手续费白名单
    // function removeFeeWhiteList(address addr) external  onlyFunder
    // {
    //    // require(address(this)!=addr,"can not remove contract from feeWhiteList");    
    //   //  require(_uniswapPair!=addr,"can not remove swappair from feeWhiteList");       
    //   //  require(_proOwnerAddress!=addr,"can not remove proOwner from feeWhiteList");
    //   //  require(_fundAddress!=addr,"can not remove fundAddress from feeWhiteList");  
    //     _feeWhiteList[addr]=false;
    // }
    //自动添加流动性最小代币数量限制
    // function setLiqiudityMinLimit(uint256 min) external  onlyFunder
    // {
    //     require(min>1,"the value you set must be greater than 1");
    //     _liqiudityMinLimitNum=min.mul(10**18);
    // }
    //设置分红USDT触发的最小缓存的代币数量
    // function setShareAutoTriggerMinLimit(uint256 value) external  onlyFunder
    // {
    //     require(value>_keepTokenMinNum+_liqiudityMinLimitNum,"autoTriggerShareNum limit must be greater than keepToken+liqiuidity");
    //     _shareTriggerLimitNum=value.mul(10**18);
    // }   
    //【测试用，正式需要移除】
    // function swapToken()external onlyFunder
    // {        
    //     require(_balances[address(this)]>10**18,"cached token can not is zero");        
    //     swapTokenForUSDT(balanceOf(address(this)));
    //     transferUSDTToContract();
    //     _liqiudityCacheTokenNum=0;
    // }
    // function testAddLiquidity() external  
    // {
    //     swapAndAddLiquidityUSDT();           
    // }

    function testTriggerShare() external onlyFunder
    {
        //>计算其他的分红       
        uint256 curBalance=balanceOf(address(this));//>这里一定要减去_liqiudityCacheTokenNum 因为有可能流动性的还没添加，还在缓存着
        triggerShare(curBalance);
        // if(curBalance>=_shareTriggerLimitNum)
        // {           
        //     swapTokenForUSDT(curBalance);//>把合约内的代币兑换成USDT
        //     transferUSDTToContract();
        //     uint256 curUSDT=USDTContract.balanceOf(address(this));
        //     uint256 usdtTotalFee=_fundFee.div(2)+_shareFee+_keepTokenFee;
        //     uint256 pUSDT=curUSDT.div(usdtTotalFee);
        //     fundShareOut(pUSDT.mul(_fundFee.div(2)));//营销钱包分红
        //     shareOut(pUSDT.mul(_shareFee));//股东分红
        //     keepTokenShareOut(pUSDT.mul(_keepTokenFee));//持币分红          
        // }      
    }
}

contract CToken is ABSToken
{
    //>这里添加股东份额【项目方钱包一定要加到股东分红里面，要不然项目方没有收益】
    address[] private  shareHolders=
        [
          0x8a00C7040C3c0E0249c8e4E2Bd739f1AFa6817B0,
          0x35324BB546F9804039BD623878751CA0FF1b8a55
        ];
    uint256[] private shares=
        [
          1000,
          2000
        ];    
    address usdtAddress=address(0x55d398326f99059fF775485246999027B3197955);  //usdt 主网合约地址： 0x55d398326f99059fF775485246999027B3197955  usdt 测试网合约地址：0x7ef95a0FEE0Dd31b22626fA2e10Ee6A223F8a684
    address swapRouterAddress=address(0x10ED43C718714eb63d5aA57B78B54704E256024E);  //v2主网路由： 0x10ED43C718714eb63d5aA57B78B54704E256024E   v2测试网路由[非官方的]:0x9Ac64Cc6e4415144C455BD8E4837Fea55603e5c3

    constructor() ABSToken(
        "XC18.0",
        "XC18",
        21000000,
        0xa39FcB63F950e7dAAB3C909cebf9E728E9503d46,//>营销钱包
        0x8a00C7040C3c0E0249c8e4E2Bd739f1AFa6817B0, //>项目方钱包
        shareHolders,
        shares,
        usdtAddress,
        swapRouterAddress,
        5000,          //>自动回流最小代币数量
        1000,         //>持币分红最小持币数量[这个值一旦确定就不能再修改，逻辑上比较复杂，gas也高，所以不再做可以修改的逻辑]
        10000){}       //分红USDT自小缓存代币数量
}