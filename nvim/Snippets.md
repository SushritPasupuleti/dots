# Snippets

## Basic Methods

|  Prefix | Method                                              |
| ------: | --------------------------------------------------- |
|  `imp→` | `import moduleName from 'module'`                   |
|  `imn→` | `import 'module'`                                   |
|  `imd→` | `import { destructuredModule } from 'module'`       |
|  `ime→` | `import * as alias from 'module'`                   |
|  `ima→` | `import { originalName as aliasName} from 'module'` |
|  `exp→` | `export default moduleName`                         |
|  `exd→` | `export { destructuredModule } from 'module'`       |
|  `exa→` | `export { originalName as aliasName} from 'module'` |
|  `enf→` | `export const functionName = (params) => { }`       |
|  `edf→` | `export default (params) => { }`                    |
| `ednf→` | `export default function functionName(params) { }`  |
|  `met→` | `methodName = (params) => { }`                      |
|  `fre→` | `arrayName.forEach(element => { }`                  |
|  `fof→` | `for(let itemName of objectName { }`                |
|  `fin→` | `for(let itemName in objectName { }`                |
| `anfn→` | `(params) => { }`                                   |
|  `nfn→` | `const functionName = (params) => { }`              |
|  `dob→` | `const {propName} = objectToDescruct`               |
|  `dar→` | `const [propName] = arrayToDescruct`                |
|  `sti→` | `setInterval(() => { }, intervalTime`               |
|  `sto→` | `setTimeout(() => { }, delayTime`                   |
| `prom→` | `return new Promise((resolve, reject) => { }`       |
| `cmmb→` | `comment block`                                     |
|   `cp→` | `const { } = this.props`                            |
|   `cs→` | `const { } = this.state`                            |

## React

|      Prefix | Method                                                                      |
| ----------: | --------------------------------------------------------------------------- |
|      `imr→` | `import React from 'react'`                                                 |
|     `imrd→` | `import ReactDOM from 'react-dom'`                                          |
|     `imrc→` | `import React, { Component } from 'react'`                                  |
|    `imrpc→` | `import React, { PureComponent } from 'react'`                              |
|     `imrm→` | `import React, { memo } from 'react'`                                       |
|     `imrr→` | `import { BrowserRouter as Router, Route, NavLink} from 'react-router-dom'` |
|     `imbr→` | `import { BrowserRouter as Router} from 'react-router-dom'`                 |
|    `imbrc→` | `import { Route, Switch, NavLink, Link } from react-router-dom'`            |
|    `imbrr→` | `import { Route } from 'react-router-dom'`                                  |
|    `imbrs→` | `import { Switch } from 'react-router-dom'`                                 |
|    `imbrl→` | `import { Link } from 'react-router-dom'`                                   |
|   `imbrnl→` | `import { NavLink } from 'react-router-dom'`                                |
|     `imrs→` | `import React, { useState } from 'react'`                                   |
|    `imrse→` | `import React, { useState, useEffect } from 'react'`                        |
|    `redux→` | `import { connect } from 'react-redux'`                                     |
|      `est→` | `this.state = { }`                                                          |
|      `cdm→` | `componentDidMount = () => { }`                                             |
|      `scu→` | `shouldComponentUpdate = (nextProps, nextState) => { }`                     |
|     `cdup→` | `componentDidUpdate = (prevProps, prevState) => { }`                        |
|     `cwun→` | `componentWillUnmount = () => { }`                                          |
|    `gdsfp→` | `static getDerivedStateFromProps(nextProps, prevState) { }`                 |
|     `gsbu→` | `getSnapshotBeforeUpdate = (prevProps, prevState) => { }`                   |
|      `sst→` | `this.setState({ })`                                                        |
|      `ssf→` | `this.setState((state, props) => return { })`                               |
|    `props→` | `this.props.propName`                                                       |
|    `state→` | `this.state.stateName`                                                      |
| `rcontext→` | `const $1 = React.createContext()`                                          |
|     `cref→` | `this.$1Ref = React.createRef()`                                            |
|     `fref→` | `const ref = React.createRef()`                                             |
|      `bnd→` | `this.methodName = this.methodName.bind(this)`                              |

## React Native

|     Prefix | Method                                 |
| ---------: | -------------------------------------- |
|    `imrn→` | `import { $1 } from 'react-native'`    |
| `rnstyle→` | `const styles = StyleSheet.create({})` |

## Redux

|       Prefix | Method                    |
| -----------: | ------------------------- |
|  `rxaction→` | `redux action template`   |
|   `rxconst→` | `export const $1 = '$1'`  |
| `rxreducer→` | `redux reducer template`  |
|  `rxselect→` | `redux selector template` |
|   `rxslice→` | `redux slice template`    |

## PropTypes

|    Prefix | Method                                   |
| --------: | ---------------------------------------- |
|    `pta→` | `PropTypes.array`                        |
|   `ptar→` | `PropTypes.array.isRequired`             |
|    `ptb→` | `PropTypes.bool`                         |
|   `ptbr→` | `PropTypes.bool.isRequired`              |
|    `ptf→` | `PropTypes.func`                         |
|   `ptfr→` | `PropTypes.func.isRequired`              |
|    `ptn→` | `PropTypes.number`                       |
|   `ptnr→` | `PropTypes.number.isRequired`            |
|    `pto→` | `PropTypes.object`                       |
|   `ptor→` | `PropTypes.object.isRequired`            |
|    `pts→` | `PropTypes.string`                       |
|   `ptsr→` | `PropTypes.string.isRequired`            |
|   `ptnd→` | `PropTypes.node`                         |
|  `ptndr→` | `PropTypes.node.isRequired`              |
|   `ptel→` | `PropTypes.element`                      |
|  `ptelr→` | `PropTypes.element.isRequired`           |
|    `pti→` | `PropTypes.instanceOf(name)`             |
|   `ptir→` | `PropTypes.instanceOf(name).isRequired`  |
|    `pte→` | `PropTypes.oneOf([name])`                |
|   `pter→` | `PropTypes.oneOf([name]).isRequired`     |
|   `ptet→` | `PropTypes.oneOfType([name])`            |
|  `ptetr→` | `PropTypes.oneOfType([name]).isRequired` |
|   `ptao→` | `PropTypes.arrayOf(name)`                |
|  `ptaor→` | `PropTypes.arrayOf(name).isRequired`     |
|   `ptoo→` | `PropTypes.objectOf(name)`               |
|  `ptoor→` | `PropTypes.objectOf(name).isRequired`    |
|   `ptsh→` | `PropTypes.shape({ })`                   |
|  `ptshr→` | `PropTypes.shape({ }).isRequired`        |
|  `ptany→` | `PropTypes.any`                          |
| `ptypes→` | `static propTypes = {}`                  |

## Console

| Prefix | Method                                                       |
| ------ | ------------------------------------------------------------ |
| `clg→` | `console.log(object)`                                        |
| `clo→` | `` console.log(`object`, object) ``                          |
| `clj→` | `` console.log(`object`, JSON.stringify(object, null, 2)) `` |
| `ctm→` | `` console.time(`timeId`) ``                                 |
| `cte→` | `` console.timeEnd(`timeId`) ``                              |
| `cas→` | `console.assert(expression,object)`                          |
| `ccl→` | `console.clear()`                                            |
| `cco→` | `console.count(label)`                                       |
| `cdi→` | `console.dir`                                                |
| `cer→` | `console.error(object)`                                      |
| `cgr→` | `console.group(label)`                                       |
| `cge→` | `console.groupEnd()`                                         |
| `ctr→` | `console.trace(object)`                                      |
| `cwa→` | `console.warn`                                               |
| `cin→` | `console.info`                                               |

