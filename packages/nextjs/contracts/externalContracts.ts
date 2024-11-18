import { GenericContract, GenericContractsDeclaration } from '~~/utils/scaffold-eth/contract'

import { PUPU_CARD_ABI } from './abi'

const externalContracts = {
  1: {
    PUPU_CARD: {
      address: "0x83dd63e529211Ff3bCC9be4c3D2559f2aE59DCbA",
      abi: PUPU_CARD_ABI,
    } as GenericContract,
  },
} as const;

export default externalContracts satisfies GenericContractsDeclaration;
